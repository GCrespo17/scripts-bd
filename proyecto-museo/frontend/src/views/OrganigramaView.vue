<template>
  <div class="organigrama-view">
    <div class="organigrama-container">
      <header class="view-header">
        <h1>Reporte de Estructura Organizacional</h1>
        <p>Visualice la jerarquía de departamentos y empleados de cada museo.</p>
      </header>

      <div class="selection-container card">
        <label for="museo-select">Seleccione un Museo:</label>
        <select id="museo-select" v-model="selectedMuseo" @change="fetchOrganigrama">
          <option disabled value="">Por favor seleccione uno</option>
          <option v-for="museo in museos" :key="museo.id" :value="museo.id">
            {{ museo.nombre }}
          </option>
        </select>
        
        <!-- Botón de exportar PDF -->
        <button 
          v-if="organigrama && museoInfo" 
          @click="exportToPDF" 
          :disabled="exportingPDF"
          class="export-button"
        >
          <span v-if="exportingPDF">📄 Generando PDF...</span>
          <span v-else>📄 Exportar PDF</span>
        </button>
      </div>

      <div v-if="loading" class="loading-state">
        <p>Cargando reporte...</p>
      </div>

      <div v-if="error" class="error-state">
        <p>Ha ocurrido un error al cargar el reporte: {{ error }}</p>
      </div>

      <!-- Contenedor del reporte con ID para captura PDF -->
      <div v-if="museoInfo && organigrama" class="report-container card" id="organigrama-content">
        <div class="report-header">
          <h2>{{ museoInfo.nombre }}</h2>
          <div class="header-details">
            <span><strong>Fundado en:</strong> {{ new Date(museoInfo.fecha_fundacion).getFullYear() }}</span>
            <span class="rank"><strong>Ranking:</strong> {{ museoInfo.ranking.categoria }}</span>
          </div>
          <p class="mission"><strong>Misión:</strong> {{ museoInfo.mision }}</p>
          <small><em>(El ranking se calcula basado en la estabilidad del personal y el volumen de visitas anuales)</em></small>
        </div>

        <div class="organigrama-content">
          <h3>Organigrama Jerárquico</h3>
          <ul class="organigrama-root">
            <OrganigramaNode v-for="node in organigrama" :key="node.id" :node="node" />
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import OrganigramaNode from '../components/OrganigramaNode.vue';

export default {
  name: 'OrganigramaView',
  components: {
    OrganigramaNode
  },
  data() {
    return {
      museos: [],
      selectedMuseo: '',
      organigrama: null,
      museoInfo: null,
      loading: false,
      error: null,
      exportingPDF: false, // Nuevo estado para el proceso de exportación
    };
  },
  methods: {
    async fetchMuseos() {
      try {
        const response = await fetch('http://localhost:3000/api/museos');
        if (!response.ok) {
          throw new Error('No se pudieron obtener los museos.');
        }
        this.museos = await response.json();
      } catch (error) {
        this.error = error.message;
        console.error(error);
      }
    },
    async fetchOrganigrama() {
      if (!this.selectedMuseo) return;
      this.loading = true;
      this.error = null;
      this.organigrama = null;
      this.museoInfo = null;

      try {
        // Fetch organigrama and museo info in parallel
        const [organigramaResponse, museoInfoResponse] = await Promise.all([
          fetch(`http://localhost:3000/api/est-organizacional/museo/${this.selectedMuseo}`),
          fetch(`http://localhost:3000/api/museos/${this.selectedMuseo}`)
        ]);

        if (!organigramaResponse.ok) {
          throw new Error('Error al obtener la estructura organizacional.');
        }
        this.organigrama = await organigramaResponse.json();
        
        // DEBUG: Ver qué datos estamos recibiendo (REMOVER EN PRODUCCIÓN)
        // console.log('ORGANIGRAMA RECIBIDO:', this.organigrama);

        if (!museoInfoResponse.ok) {
          throw new Error('Error al obtener la información del museo.');
        }
        this.museoInfo = await museoInfoResponse.json();

      } catch (error) {
        this.error = error.message;
        console.error(error);
      } finally {
        this.loading = false;
      }
    },

    async exportToPDF() {
      this.exportingPDF = true;
      
      try {
        const jsPDF = (await import('jspdf')).default;
        
        const pdf = new jsPDF('portrait', 'mm', 'a4');
        const pageWidth = pdf.internal.pageSize.getWidth();
        const pageHeight = pdf.internal.pageSize.getHeight();
        let yPosition = 20;
        
        const checkNewPage = (requiredHeight) => {
          if (yPosition + requiredHeight > pageHeight - 20) {
            pdf.addPage();
            yPosition = 20;
          }
        };
        
        // --- FUNCIONES HELPER PARA TEXTO SEGURO ---
        const safeText = (text) => {
          if (text === null || text === undefined) return '';
          return String(text).trim();
        };

        const safeSplitText = (text, maxWidth) => {
          const cleanText = safeText(text);
          if (!cleanText) return [''];
          try {
            return pdf.splitTextToSize(cleanText, maxWidth);
          } catch (error) {
            console.warn('Error al dividir texto:', cleanText, error);
            return [cleanText];
          }
        };

        const safeDrawText = (text, x, y, options = {}) => {
          const cleanText = safeText(text);
          if (!cleanText) return;
          
          try {
            pdf.text(cleanText, x, y, options);
          } catch (error) {
            console.warn('Error al dibujar texto:', cleanText, error);
          }
        };

        // --- INICIO CABECERA PDF ---
        pdf.setFontSize(18);
        pdf.setFont('helvetica', 'bold');
        safeDrawText('REPORTE DE ESTRUCTURA ORGANIZACIONAL', pageWidth / 2, yPosition, { align: 'center' });
        yPosition += 15;
        
        pdf.setLineWidth(0.5);
        pdf.line(20, yPosition, pageWidth - 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'bold');
        safeDrawText('MUSEO:', 20, yPosition);
        pdf.setFont('helvetica', 'normal');
        safeDrawText(this.museoInfo.nombre || 'Sin nombre', 45, yPosition);
        yPosition += 8;
        
        pdf.setFont('helvetica', 'bold');
        safeDrawText('FUNDADO:', 20, yPosition);
        pdf.setFont('helvetica', 'normal');
        const anioFundacion = this.museoInfo.fecha_fundacion 
          ? new Date(this.museoInfo.fecha_fundacion).getFullYear().toString()
          : 'No disponible';
        safeDrawText(anioFundacion, 50, yPosition);
        yPosition += 8;
        
        pdf.setFont('helvetica', 'bold');
        safeDrawText('RANKING:', 20, yPosition);
        pdf.setFont('helvetica', 'normal');
        const rankingCategoria = this.museoInfo.ranking?.categoria || 'Sin ranking';
        safeDrawText(rankingCategoria, 50, yPosition);
        yPosition += 8;
        
        pdf.setFont('helvetica', 'bold');
        safeDrawText('MISIÓN:', 20, yPosition);
        yPosition += 6;
        
        pdf.setFont('helvetica', 'italic');
        pdf.setFontSize(10);
        const misionText = this.museoInfo.mision || 'No disponible';
        const missionLines = safeSplitText(misionText, pageWidth - 50); // Más margen para la misión
        
        try {
          pdf.text(missionLines, 20, yPosition);
          yPosition += missionLines.length * (10 * 0.5);
        } catch (error) {
          console.warn('Error al dibujar misión:', error);
          safeDrawText('Misión no disponible', 20, yPosition);
          yPosition += 5;
        }
        yPosition += 4;
        
        pdf.setLineWidth(0.3);
        pdf.line(20, yPosition, pageWidth - 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('ESTRUCTURA ORGANIZACIONAL:', 20, yPosition);
        yPosition += 10;
        // --- FIN CABECERA PDF ---

        const drawOrganigramaNode = (node, level = 0, parentNumber = '', siblingIndex = 0) => {
          const indent = 20 + (level * 12); // Reducir indentación para más espacio
          const nodeNumber = level === 0 ? (siblingIndex + 1).toString() : `${parentNumber}.${siblingIndex + 1}`;
          const contentMaxWidth = pageWidth - indent - 35; // Más margen para evitar desbordamiento

          // Validaciones de datos de entrada
          const nodeNombre = node.nombre || 'Sin nombre';
          const nodeTipo = node.tipo || 'Sin tipo';
          const nodeDescripcion = node.descripcion || '';

          const jefesArray = Array.isArray(node.jefes) ? node.jefes : [];
          const personalArray = Array.isArray(node.personal) ? node.personal : [];
          const totalEmpleados = jefesArray.length + personalArray.length;

          const lh = { tiny: 3, small: 4, medium: 5, large: 6 };

          // Función helper para validar texto antes de usar splitTextToSize
          const safeText = (text) => {
            if (text === null || text === undefined) return '';
            return String(text).trim();
          };

          // Función helper para dividir texto de forma segura
          const safeSplitText = (text, maxWidth) => {
            const cleanText = safeText(text);
            if (!cleanText) return [''];
            try {
              return pdf.splitTextToSize(cleanText, maxWidth);
            } catch (error) {
              console.warn('Error al dividir texto:', cleanText, error);
              return [cleanText];
            }
          };

          // Función helper para dibujar texto de forma segura
          const safeDrawText = (textLines, x, y, lineHeight = 5) => {
            if (!Array.isArray(textLines)) {
              textLines = [safeText(textLines)];
            }
            const validLines = textLines.filter(line => safeText(line));
            if (validLines.length === 0) return 0;
            
            try {
              // Dibujar línea por línea para mejor control del espaciado
              validLines.forEach((line, index) => {
                pdf.text(line, x, y + (index * lineHeight));
              });
              return validLines.length;
            } catch (error) {
              console.warn('Error al dibujar texto:', validLines, error);
              return 0;
            }
          };

          // --- 1. Calcular Altura del Bloque ---
          let calculatedHeight = 0;

          // Hacer wrapping del título en lugar de cortarlo
          const titleText = `${nodeNumber}. ${nodeNombre}`;
          const titleLines = safeSplitText(titleText, contentMaxWidth);
          calculatedHeight += titleLines.length * lh.medium;

          calculatedHeight += lh.small; // Empleados asignados

          if (nodeDescripcion) {
            const descLines = safeSplitText(nodeDescripcion, contentMaxWidth);
            calculatedHeight += descLines.length * lh.small;
          }

          if (jefesArray.length > 0) {
            calculatedHeight += lh.large; // "DIRECCION:"
            jefesArray.forEach(jefe => {
              const jefeNombre = safeText(jefe.nombre_completo);
              const jefeCargo = safeText(jefe.cargo);
              if (jefeNombre) {
                calculatedHeight += safeSplitText(`• ${jefeNombre}`, contentMaxWidth - 15).length * lh.small;
                calculatedHeight += safeSplitText(`  ${jefeCargo}`, contentMaxWidth - 20).length * lh.tiny;
              }
            });
          }
          
          if (personalArray.length > 0) {
            calculatedHeight += lh.large;
            personalArray.forEach(empleado => {
              const empNombre = safeText(empleado.nombre_completo);
              const empCargo = safeText(empleado.cargo);
              if (empNombre) {
                calculatedHeight += safeSplitText(`• ${empNombre} - ${empCargo}`, contentMaxWidth - 15).length * lh.small;
              }
            });
          }
          
          if (totalEmpleados === 0) calculatedHeight += lh.small;
          
          const nodeHeight = calculatedHeight + 12;

          checkNewPage(nodeHeight);
          const startY = yPosition;

          // --- 2. Dibujar Contenedor ---
          const bgColors = [[230, 245, 255], [230, 255, 230], [255, 240, 230], [245, 230, 255]];
          const bgColor = bgColors[Math.min(level, bgColors.length - 1)];
          const containerWidth = pageWidth - indent - 25; // Más conservador para evitar desbordamiento
          pdf.setFillColor(bgColor[0], bgColor[1], bgColor[2]);
          pdf.rect(indent, startY - 4, containerWidth, nodeHeight, 'F');
          pdf.setDrawColor(150, 150, 150);
          pdf.setLineWidth(0.2);
          pdf.rect(indent, startY - 4, containerWidth, nodeHeight);

          yPosition = startY;

          // --- 3. Dibujar Contenido (con wrapping y validaciones) ---
          // Ajustar tamaño de fuente según el nivel para evitar desbordamientos
          const titleFontSize = Math.max(10, 12 - level);
          pdf.setFontSize(titleFontSize);
          pdf.setFont('helvetica', 'bold');
          pdf.setTextColor(0, 0, 0);
          
          // Dibujar el título con espaciado adecuado entre líneas
          const titleLineHeight = titleFontSize * 0.7; // Espaciado proporcional al tamaño de fuente
          const drawnTitleLines = safeDrawText(titleLines, indent + 3, yPosition, titleLineHeight);
          yPosition += drawnTitleLines * lh.medium;

          pdf.setFontSize(9);
          pdf.setFont('helvetica', 'normal');
          pdf.setTextColor(100, 100, 100);
          const empleadosText = `${totalEmpleados} empleado${totalEmpleados !== 1 ? 's' : ''} asignado${totalEmpleados !== 1 ? 's' : ''}`;
          safeDrawText(empleadosText, indent + 3, yPosition, 4);
          yPosition += lh.small;

          if (nodeDescripcion) {
            pdf.setFontSize(8);
            pdf.setFont('helvetica', 'italic');
            const descLines = safeSplitText(nodeDescripcion, contentMaxWidth);
            const drawnDescLines = safeDrawText(descLines, indent + 3, yPosition, 3.5);
            yPosition += drawnDescLines * lh.small;
          }

          if (jefesArray.length > 0) {
            yPosition += 2;
            pdf.setFontSize(10);
            pdf.setFont('helvetica', 'bold');
            pdf.setTextColor(0, 0, 0);
            safeDrawText(`DIRECCION (${jefesArray.length}):`, indent + 5, yPosition, 4.5);
            yPosition += lh.medium;
            
            jefesArray.forEach(jefe => {
              const jefeNombre = safeText(jefe.nombre_completo);
              const jefeCargo = safeText(jefe.cargo);
              
                             if (jefeNombre) {
                 pdf.setFontSize(9);
                 pdf.setFont('helvetica', 'bold');
                 const jefeNameLines = safeSplitText(`• ${jefeNombre}`, contentMaxWidth - 15);
                 const drawnJefeLines = safeDrawText(jefeNameLines, indent + 8, yPosition, 4);
                 yPosition += drawnJefeLines * lh.small;
                 
                 if (jefeCargo) {
                   pdf.setFontSize(8);
                   pdf.setFont('helvetica', 'normal');
                   pdf.setTextColor(80, 80, 80);
                   const cargoLines = safeSplitText(jefeCargo, contentMaxWidth - 20);
                   const drawnCargoLines = safeDrawText(cargoLines, indent + 12, yPosition, 3);
                   yPosition += drawnCargoLines * lh.tiny + 1;
                 }
              }
            });
          }

          if (personalArray.length > 0) {
            yPosition += 2;
            pdf.setFontSize(10);
            pdf.setFont('helvetica', 'bold');
            pdf.setTextColor(0, 0, 0);
            safeDrawText(`PERSONAL (${personalArray.length}):`, indent + 5, yPosition, 4.5);
            yPosition += lh.medium;
            
            personalArray.forEach(empleado => {
              const empNombre = safeText(empleado.nombre_completo);
              const empCargo = safeText(empleado.cargo);
              
                             if (empNombre) {
                 pdf.setFontSize(8);
                 pdf.setFont('helvetica', 'normal');
                 pdf.setTextColor(50, 50, 50);
                 const empText = empCargo ? `• ${empNombre} - ${empCargo}` : `• ${empNombre}`;
                 const empLines = safeSplitText(empText, contentMaxWidth - 15);
                 const drawnEmpLines = safeDrawText(empLines, indent + 8, yPosition, 3.5);
                 yPosition += drawnEmpLines * lh.small;
              }
            });
          }

          if (totalEmpleados === 0) {
            pdf.setFontSize(9);
            pdf.setFont('helvetica', 'italic');
            pdf.setTextColor(150, 150, 150);
            safeDrawText('Sin personal asignado actualmente', indent + 5, yPosition, 4);
          }
          
          yPosition = startY + nodeHeight + 2;

          if (node.children && Array.isArray(node.children) && node.children.length > 0) {
            node.children.forEach((child, childIndex) => {
              drawOrganigramaNode(child, level + 1, nodeNumber, childIndex);
            });
          }
        };

        this.organigrama.forEach((rootNode, index) => {
          drawOrganigramaNode(rootNode, 0, '', index);
        });
        
        // --- FOOTER ---
        const totalPages = pdf.internal.getNumberOfPages();
        for (let i = 1; i <= totalPages; i++) {
          pdf.setPage(i);
          pdf.setFontSize(8);
          pdf.setFont('helvetica', 'normal');
          pdf.setTextColor(100, 100, 100);
          const fechaGeneracion = new Date().toLocaleString('es-ES');
          safeDrawText(`Generado el: ${fechaGeneracion}`, 20, pageHeight - 10);
          safeDrawText(`Página ${i} de ${totalPages}`, pageWidth - 40, pageHeight - 10);
        }
        
        const fecha = new Date().toLocaleDateString('es-ES').replace(/\//g, '-');
        const nombreMuseo = safeText(this.museoInfo.nombre).replace(/[^\w\s-]/g, '').replace(/\s+/g, '_') || 'Museo';
        const nombreArchivo = `Organigrama_${nombreMuseo}_${fecha}.pdf`;
        
        pdf.save(nombreArchivo);

      } catch (error) {
        console.error('Error al exportar PDF:', error);
        alert('Error al generar el PDF. Por favor, inténtelo de nuevo.');
      } finally {
        this.exportingPDF = false;
      }
    }
  },
  created() {
    this.fetchMuseos();
  }
};
</script>

<style scoped>
.organigrama-view {
  padding: 1rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100%;
  width: 100%;
  box-sizing: border-box;
}

.organigrama-container {
  max-width: 1400px;
  margin: 0 auto;
}

.view-header {
  text-align: center;
  margin-bottom: 2rem;
  color: white;
  padding: 0 1rem;
}

.view-header h1 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  text-shadow: 0 2px 4px rgba(0,0,0,0.3);
}

.view-header p {
  font-size: 1.1rem;
  opacity: 0.9;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

.card {
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.15), 0 4px 10px rgba(0,0,0,0.1);
  padding: 2rem;
  margin-bottom: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.2);
  width: 100%;
  box-sizing: border-box;
}

.selection-container {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
  width: 100%;
}

.selection-container label {
  font-weight: 600;
  color: #374151;
  font-size: 1rem;
  white-space: nowrap;
}

select {
  flex: 1;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  border: 2px solid #e5e7eb;
  font-size: 1rem;
  transition: all 0.2s ease;
  background-color: white;
  min-width: 200px;
  max-width: 100%;
}

select:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

/* Nuevo estilo para el botón de exportar PDF */
.export-button {
  background: linear-gradient(135deg, #059669 0%, #047857 100%);
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 8px rgba(5, 150, 105, 0.3);
  white-space: nowrap;
  flex-shrink: 0;
}

.export-button:hover:not(:disabled) {
  background: linear-gradient(135deg, #047857 0%, #065f46 100%);
  transform: translateY(-1px);
  box-shadow: 0 6px 12px rgba(5, 150, 105, 0.4);
}

.export-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.export-button:active {
  transform: translateY(0);
}

.loading-state, .error-state {
  text-align: center;
  padding: 3rem;
  border-radius: 16px;
  width: 100%;
  box-sizing: border-box;
}

.loading-state {
  background: linear-gradient(135deg, #f3f4f6 0%, #ffffff 100%);
  color: #6b7280;
}

.error-state {
  background: linear-gradient(135deg, #fef2f2 0%, #ffffff 100%);
  color: #dc2626;
  border: 1px solid #fecaca;
}

.report-container {
  background: linear-gradient(135deg, #ffffff 0%, #f9fafb 100%);
  border: none;
  box-shadow: 0 20px 40px rgba(0,0,0,0.1);
  width: 100%;
  box-sizing: border-box;
}

.report-header {
  border-bottom: 3px solid #f0f0f0;
  padding-bottom: 2rem;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #f8fafc 0%, transparent 100%);
  padding: 2rem;
  margin: -2rem -2rem 2rem -2rem;
  border-radius: 16px 16px 0 0;
}

.report-header h2 {
  color: #1f2937;
  margin-top: 0;
  font-size: 2rem;
  font-weight: 700;
  text-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.header-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  flex-wrap: wrap;
  gap: 1rem;
}

.header-details span {
  font-size: 1rem;
  color: #374151;
}

.rank {
  background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
  color: white;
  padding: 0.5rem 1.2rem;
  border-radius: 25px;
  font-weight: 700;
  font-size: 0.9rem;
  box-shadow: 0 4px 8px rgba(59, 130, 246, 0.3);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.mission {
  font-style: italic;
  color: #555;
  font-size: 1.1rem;
  line-height: 1.6;
  margin: 1rem 0;
  padding: 1rem;
  background-color: #f8fafc;
  border-radius: 8px;
  border-left: 4px solid #3b82f6;
}

.organigrama-content {
  width: 100%;
  overflow-x: auto;
}

.organigrama-content h3 {
  color: #1f2937;
  border-bottom: 3px solid #3b82f6;
  padding-bottom: 0.75rem;
  margin-bottom: 2rem;
  font-size: 1.5rem;
  font-weight: 700;
  position: relative;
}

.organigrama-content h3::after {
  content: '';
  position: absolute;
  bottom: -3px;
  left: 0;
  width: 60px;
  height: 3px;
  background: linear-gradient(90deg, #3b82f6 0%, #1d4ed8 100%);
  border-radius: 2px;
}

.organigrama-root {
  list-style: none;
  padding: 0;
  margin: 2rem 0 0 0;
  width: 100%;
  min-width: fit-content;
}

/* Responsive mejoras */
@media (max-width: 768px) {
  .organigrama-view {
    padding: 0.5rem;
  }
  
  .view-header {
    padding: 0 0.5rem;
  }
  
  .view-header h1 {
    font-size: 2rem;
  }
  
  .card {
    padding: 1.5rem;
    margin-bottom: 1.5rem;
  }
  
  .selection-container {
    flex-direction: column;
    align-items: stretch;
    gap: 1rem;
  }
  
  .selection-container label {
    text-align: center;
  }
  
  select {
    min-width: unset;
    width: 100%;
  }
  
  .header-details {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .report-header {
    padding: 1.5rem;
    margin: -1.5rem -1.5rem 1.5rem -1.5rem;
  }

  .export-button {
    width: 100%;
    margin-top: 1rem;
  }
  
  .organigrama-content {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
}

@media (max-width: 480px) {
  .organigrama-view {
    padding: 0.25rem;
  }
  
  .view-header h1 {
    font-size: 1.75rem;
  }
  
  .card {
    padding: 1rem;
  }
}

/* Estilos específicos para impresión PDF */
@media print {
  .organigrama-view {
    background: white;
    padding: 0;
    margin: 0;
    width: 100%;
  }
  
  .view-header,
  .selection-container {
    display: none;
  }
  
  .report-container {
    box-shadow: none;
    border-radius: 0;
    margin: 0;
    padding: 20px;
    width: 100%;
  }
}
</style> 