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
        // Importación dinámica de jsPDF
        const jsPDF = (await import('jspdf')).default;
        
        // Crear el PDF en orientación vertical A4
        const pdf = new jsPDF('portrait', 'mm', 'a4');
        const pageWidth = pdf.internal.pageSize.getWidth();
        const pageHeight = pdf.internal.pageSize.getHeight();
        let yPosition = 20;
        
        // Función helper para verificar si necesitamos nueva página
        const checkNewPage = (requiredHeight) => {
          if (yPosition + requiredHeight > pageHeight - 20) {
            pdf.addPage();
            yPosition = 20;
            return true;
          }
          return false;
        };
        
        // Función para agregar texto con ajuste automático
        const addWrappedText = (text, x, maxWidth, fontSize = 10) => {
          pdf.setFontSize(fontSize);
          const lines = pdf.splitTextToSize(text, maxWidth);
          const lineHeight = fontSize * 0.4;
          
          checkNewPage(lines.length * lineHeight);
          
          lines.forEach(line => {
            pdf.text(line, x, yPosition);
            yPosition += lineHeight;
          });
          return yPosition;
        };
        
        // HEADER DEL DOCUMENTO
        pdf.setFontSize(18);
        pdf.setFont('helvetica', 'bold');
        pdf.text('REPORTE DE ESTRUCTURA ORGANIZACIONAL', pageWidth / 2, yPosition, { align: 'center' });
        yPosition += 15;
        
        // Línea separadora
        pdf.setLineWidth(0.5);
        pdf.line(20, yPosition, pageWidth - 20, yPosition);
        yPosition += 10;
        
        // INFORMACIÓN DEL MUSEO
        pdf.setFontSize(14);
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
        
        // MISIÓN
        pdf.setFont('helvetica', 'bold');
        pdf.text('MISION:', 20, yPosition);
        yPosition += 6;
        pdf.setFont('helvetica', 'italic');
        yPosition = addWrappedText(this.museoInfo.mision, 20, pageWidth - 40, 10);
        yPosition += 10;
        
        // Línea separadora
        pdf.setLineWidth(0.3);
        pdf.line(20, yPosition, pageWidth - 20, yPosition);
        yPosition += 10;
        
        // ORGANIGRAMA
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('ESTRUCTURA ORGANIZACIONAL:', 20, yPosition);
        yPosition += 10;
        
        // Función recursiva para dibujar el organigrama (CORREGIDA)
        const drawOrganigramaNode = (node, level = 0, parentNumber = '', siblingIndex = 0) => {
          const indent = 20 + (level * 15);
          
          // Corregir la numeración secuencial
          let nodeNumber;
          if (level === 0) {
            nodeNumber = (siblingIndex + 1).toString();
          } else {
            nodeNumber = parentNumber + '.' + (siblingIndex + 1);
          }
          
          // Calcular total de empleados correctamente (manejo de Proxies de Vue)
          const jefesArray = Array.isArray(node.jefes) ? node.jefes : [];
          const personalArray = Array.isArray(node.personal) ? node.personal : [];
          const totalEmpleados = jefesArray.length + personalArray.length;
          
          // Calcular altura necesaria para el nodo completo
          let nodeHeight = 20; // Altura base reducida
          
          // Añadir altura para el título (puede ser múltiples líneas)
          const maxTitleWidth = pageWidth - indent - 25;
          const titleLinesForHeight = pdf.splitTextToSize(`${nodeNumber}. ${node.nombre}`, maxTitleWidth);
          nodeHeight += titleLinesForHeight.length * 5;
          
          if (node.descripcion) nodeHeight += 8;
          if (jefesArray.length > 0) nodeHeight += 8 + (jefesArray.length * 6);
          if (personalArray.length > 0) nodeHeight += 8 + (personalArray.length * 4);
          if (totalEmpleados === 0) nodeHeight += 8;
          
          checkNewPage(nodeHeight + 10);
          
          // Fondo del nodo según el nivel
          const bgColors = [
            [230, 245, 255], // Azul claro
            [230, 255, 230], // Verde claro  
            [255, 240, 230], // Naranja claro
            [245, 230, 255], // Violeta claro
          ];
          const bgColor = bgColors[level % bgColors.length];
          
          pdf.setFillColor(bgColor[0], bgColor[1], bgColor[2]);
          pdf.rect(indent, yPosition - 3, pageWidth - indent - 20, nodeHeight, 'F');
          
          // Borde del nodo
          pdf.setDrawColor(100, 100, 100);
          pdf.setLineWidth(0.2);
          pdf.rect(indent, yPosition - 3, pageWidth - indent - 20, nodeHeight);
          
          // Título del nodo con text wrapping
          pdf.setFontSize(12);
          pdf.setFont('helvetica', 'bold');
          pdf.setTextColor(0, 0, 0);
          
          const titleText = `${nodeNumber}. ${node.nombre}`;
          const titleLines = pdf.splitTextToSize(titleText, maxTitleWidth);
          titleLines.forEach((line, index) => {
            pdf.text(line, indent + 3, yPosition + 2 + (index * 5));
          });
          yPosition += titleLines.length * 5 + 3;
          
          // Solo mostrar total de empleados (sin información redundante)
          if (totalEmpleados > 0) {
            pdf.setFontSize(9);
            pdf.setFont('helvetica', 'normal');
            pdf.setTextColor(100, 100, 100);
            pdf.text(`${totalEmpleados} empleado${totalEmpleados > 1 ? 's' : ''} asignado${totalEmpleados > 1 ? 's' : ''}`, indent + 3, yPosition);
            yPosition += 6;
          }
          
          // Descripción si existe
          if (node.descripcion) {
            pdf.setFontSize(8);
            pdf.setFont('helvetica', 'italic');
            pdf.setTextColor(80, 80, 80);
            const maxDescWidth = pageWidth - indent - 25;
            const descLines = pdf.splitTextToSize(node.descripcion, maxDescWidth);
            descLines.slice(0, 2).forEach(line => { // Máximo 2 líneas
              pdf.text(line, indent + 3, yPosition);
              yPosition += 3;
            });
            yPosition += 2;
          }
          
          // DIRECCIÓN/JEFES (dentro de la tarjeta)
          if (jefesArray.length > 0) {
            pdf.setFontSize(10);
            pdf.setFont('helvetica', 'bold');
            pdf.setTextColor(0, 0, 0);
            pdf.text(`DIRECCION (${jefesArray.length}):`, indent + 5, yPosition);
            yPosition += 4;
            
            jefesArray.forEach((jefe) => {
              pdf.setFontSize(9);
              pdf.setFont('helvetica', 'bold');
              pdf.setTextColor(0, 0, 0);
              
              // Text wrapping para nombres largos
              const jefeText = `• ${jefe.nombre_completo}`;
              const maxNameWidth = pageWidth - indent - 35;
              const nameLines = pdf.splitTextToSize(jefeText, maxNameWidth);
              nameLines.forEach((line, index) => {
                pdf.text(line, indent + 10, yPosition + (index * 3));
              });
              yPosition += nameLines.length * 3;
              
              pdf.setFont('helvetica', 'normal');
              pdf.setTextColor(60, 60, 60);
              const cargoLines = pdf.splitTextToSize(`  ${jefe.cargo}`, maxNameWidth);
              cargoLines.forEach((line, index) => {
                pdf.text(line, indent + 12, yPosition + (index * 3));
              });
              yPosition += cargoLines.length * 3;
            });
            yPosition += 2;
          }
          
          // PERSONAL (dentro de la tarjeta)
          if (personalArray.length > 0) {
            pdf.setFontSize(10);
            pdf.setFont('helvetica', 'bold');
            pdf.setTextColor(0, 0, 0);
            pdf.text(`PERSONAL (${personalArray.length}):`, indent + 5, yPosition);
            yPosition += 4;
            
            personalArray.forEach((empleado) => {
              pdf.setFontSize(8);
              pdf.setFont('helvetica', 'normal');
              pdf.setTextColor(0, 0, 0);
              
              // Text wrapping para nombres largos del personal
              const empleadoText = `• ${empleado.nombre_completo} - ${empleado.cargo}`;
              const maxEmpWidth = pageWidth - indent - 35;
              const empLines = pdf.splitTextToSize(empleadoText, maxEmpWidth);
              empLines.forEach((line, index) => {
                pdf.text(line, indent + 10, yPosition + (index * 3));
              });
              yPosition += empLines.length * 3;
            });
            yPosition += 2;
          }
          
          // Mensaje si no hay empleados (dentro de la tarjeta)
          if (totalEmpleados === 0) {
            pdf.setFontSize(9);
            pdf.setFont('helvetica', 'italic');
            pdf.setTextColor(100, 100, 100);
            pdf.text('Sin personal asignado actualmente', indent + 5, yPosition);
            pdf.setTextColor(0, 0, 0);
            yPosition += 4;
          }
          
          yPosition += 5; // Espacio después del nodo
          
          // Procesar hijos con numeración correcta
          if (node.children && node.children.length > 0) {
            node.children.forEach((child, childIndex) => {
              drawOrganigramaNode(child, level + 1, nodeNumber, childIndex);
            });
          }
          
          yPosition += 3; // Espacio entre nodos del mismo nivel
        };
        
        // Dibujar todos los nodos raíz con numeración correcta
        this.organigrama.forEach((rootNode, index) => {
          drawOrganigramaNode(rootNode, 0, '', index);
        });
        
        // FOOTER
        const totalPages = pdf.internal.getNumberOfPages();
        for (let i = 1; i <= totalPages; i++) {
          pdf.setPage(i);
          pdf.setFontSize(8);
          pdf.setFont('helvetica', 'normal');
          pdf.setTextColor(100, 100, 100);
          
          // Fecha de generación
          const fechaGeneracion = new Date().toLocaleString('es-ES');
          pdf.text(`Generado el: ${fechaGeneracion}`, 20, pageHeight - 10);
          
          // Número de página
          pdf.text(`Pagina ${i} de ${totalPages}`, pageWidth - 40, pageHeight - 10);
        }
        
        // Generar nombre del archivo
        const fecha = new Date().toLocaleDateString('es-ES').replace(/\//g, '-');
        const nombreArchivo = `Organigrama_${this.museoInfo.nombre.replace(/\s+/g, '_')}_${fecha}.pdf`;
        
        // Descargar el PDF
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