<template>
  <div class="organigrama-view">
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
        
        // --- INICIO CABECERA PDF ---
        pdf.setFontSize(18);
        pdf.setFont('helvetica', 'bold');
        pdf.text('REPORTE DE ESTRUCTURA ORGANIZACIONAL', pageWidth / 2, yPosition, { align: 'center' });
        yPosition += 15;
        
        pdf.setLineWidth(0.5);
        pdf.line(20, yPosition, pageWidth - 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'bold');
        pdf.text('MUSEO:', 20, yPosition);
        pdf.setFont('helvetica', 'normal');
        pdf.text(this.museoInfo.nombre, 45, yPosition);
        yPosition += 8;
        
        pdf.setFont('helvetica', 'bold');
        pdf.text('FUNDADO:', 20, yPosition);
        pdf.setFont('helvetica', 'normal');
        pdf.text(new Date(this.museoInfo.fecha_fundacion).getFullYear().toString(), 50, yPosition);
        yPosition += 8;
        
        pdf.setFont('helvetica', 'bold');
        pdf.text('RANKING:', 20, yPosition);
        pdf.setFont('helvetica', 'normal');
        pdf.text(this.museoInfo.ranking.categoria, 50, yPosition);
        yPosition += 8;
        
        pdf.setFont('helvetica', 'bold');
        pdf.text('MISIÓN:', 20, yPosition);
        yPosition += 6;
        
        pdf.setFont('helvetica', 'italic');
        pdf.setFontSize(10);
        const missionLines = pdf.splitTextToSize(this.museoInfo.mision, pageWidth - 40);
        pdf.text(missionLines, 20, yPosition);
        yPosition += missionLines.length * (10 * 0.5);
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
          const indent = 20 + (level * 15);
          const nodeNumber = level === 0 ? (siblingIndex + 1).toString() : `${parentNumber}.${siblingIndex + 1}`;
          const contentMaxWidth = pageWidth - indent - 28;

          const jefesArray = Array.isArray(node.jefes) ? node.jefes : [];
          const personalArray = Array.isArray(node.personal) ? node.personal : [];
          const totalEmpleados = jefesArray.length + personalArray.length;

          const lh = { tiny: 3, small: 4, medium: 5, large: 6 };

          // --- 1. Calcular Altura del Bloque ---
          let calculatedHeight = 0;

          const titleText = `${nodeNumber}. ${node.nombre} (${node.tipo})`;
          calculatedHeight += pdf.splitTextToSize(titleText, contentMaxWidth).length * lh.medium;

          calculatedHeight += lh.small; // Empleados asignados

          if (node.descripcion) {
            calculatedHeight += pdf.splitTextToSize(node.descripcion, contentMaxWidth).slice(0, 3).length * lh.small;
          }

          if (jefesArray.length > 0) {
            calculatedHeight += lh.large; // "DIRECCION:"
            jefesArray.forEach(jefe => {
              calculatedHeight += pdf.splitTextToSize(`• ${jefe.nombre_completo}`, contentMaxWidth - 5).length * lh.small;
              calculatedHeight += pdf.splitTextToSize(`  ${jefe.cargo}`, contentMaxWidth - 7).length * lh.tiny;
            });
          }
          
          if (personalArray.length > 0) {
            calculatedHeight += lh.large;
            personalArray.forEach(empleado => {
              calculatedHeight += pdf.splitTextToSize(`• ${empleado.nombre_completo} - ${empleado.cargo}`, contentMaxWidth - 5).length * lh.small;
            });
          }
          
          if (totalEmpleados === 0) calculatedHeight += lh.small;
          
          const nodeHeight = calculatedHeight + 12;

          checkNewPage(nodeHeight);
          const startY = yPosition;

          // --- 2. Dibujar Contenedor ---
          const bgColors = [[230, 245, 255], [230, 255, 230], [255, 240, 230], [245, 230, 255]];
          const bgColor = bgColors[Math.min(level, bgColors.length - 1)];
          pdf.setFillColor(bgColor[0], bgColor[1], bgColor[2]);
          pdf.rect(indent, startY - 4, pageWidth - indent - 20, nodeHeight, 'F');
          pdf.setDrawColor(150, 150, 150);
          pdf.setLineWidth(0.2);
          pdf.rect(indent, startY - 4, pageWidth - indent - 20, nodeHeight);

          yPosition = startY;

          // --- 3. Dibujar Contenido (con wrapping) ---
          pdf.setFontSize(12);
          pdf.setFont('helvetica', 'bold');
          pdf.setTextColor(0, 0, 0);
          const titleLines = pdf.splitTextToSize(titleText, contentMaxWidth);
          pdf.text(titleLines, indent + 3, yPosition);
          yPosition += titleLines.length * lh.medium;

          pdf.setFontSize(9);
          pdf.setFont('helvetica', 'normal');
          pdf.setTextColor(100, 100, 100);
          pdf.text(`${totalEmpleados} empleado${totalEmpleados > 1 ? 's' : ''} asignado${totalEmpleados > 1 ? 's' : ''}`, indent + 3, yPosition);
          yPosition += lh.small;

          if (node.descripcion) {
            pdf.setFontSize(8);
            pdf.setFont('helvetica', 'italic');
            const descLines = pdf.splitTextToSize(node.descripcion, contentMaxWidth);
            pdf.text(descLines.slice(0, 3), indent + 3, yPosition);
            yPosition += descLines.slice(0, 3).length * lh.small;
          }

          if (jefesArray.length > 0) {
            yPosition += 2;
            pdf.setFontSize(10);
            pdf.setFont('helvetica', 'bold');
            pdf.setTextColor(0,0,0);
            pdf.text(`DIRECCION (${jefesArray.length}):`, indent + 5, yPosition);
            yPosition += lh.medium;
            
            jefesArray.forEach(jefe => {
              pdf.setFontSize(9);
              pdf.setFont('helvetica', 'bold');
              const jefeNameLines = pdf.splitTextToSize(`• ${jefe.nombre_completo}`, contentMaxWidth - 5);
              pdf.text(jefeNameLines, indent + 8, yPosition);
              yPosition += jefeNameLines.length * lh.small;
              
              pdf.setFontSize(8);
              pdf.setFont('helvetica', 'normal');
              pdf.setTextColor(80, 80, 80);
              const cargoLines = pdf.splitTextToSize(`${jefe.cargo}`, contentMaxWidth - 7);
              pdf.text(cargoLines, indent + 12, yPosition);
              yPosition += cargoLines.length * lh.tiny + 1;
            });
          }

          if (personalArray.length > 0) {
            yPosition += 2;
            pdf.setFontSize(10);
            pdf.setFont('helvetica', 'bold');
            pdf.setTextColor(0,0,0);
            pdf.text(`PERSONAL (${personalArray.length}):`, indent + 5, yPosition);
            yPosition += lh.medium;
            
            personalArray.forEach(empleado => {
              pdf.setFontSize(8);
              pdf.setFont('helvetica', 'normal');
              pdf.setTextColor(50, 50, 50);
              const empLines = pdf.splitTextToSize(`• ${empleado.nombre_completo} - ${empleado.cargo}`, contentMaxWidth - 5);
              pdf.text(empLines, indent + 8, yPosition);
              yPosition += empLines.length * lh.small;
            });
          }

          if (totalEmpleados === 0) {
            pdf.setFontSize(9);
            pdf.setFont('helvetica', 'italic');
            pdf.setTextColor(150, 150, 150);
            pdf.text('Sin personal asignado actualmente', indent + 5, yPosition);
          }
          
          yPosition = startY + nodeHeight + 2;

          if (node.children && node.children.length > 0) {
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
          pdf.text(`Generado el: ${fechaGeneracion}`, 20, pageHeight - 10);
          pdf.text(`Página ${i} de ${totalPages}`, pageWidth - 40, pageHeight - 10);
        }
        
        const fecha = new Date().toLocaleDateString('es-ES').replace(/\//g, '-');
        const nombreArchivo = `Organigrama_${this.museoInfo.nombre.replace(/\s+/g, '_')}_${fecha}.pdf`;
        
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
  max-width: 1400px;
  margin: 0 auto;
  padding: 1rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  border-radius: 0;
  width: 100%;
  box-sizing: border-box;
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