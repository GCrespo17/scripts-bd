<template>
  <div class="employee-details-panel card">
    <div class="panel-header">
      <button @click="$emit('back-to-list')" class="back-button" title="Volver a la lista">&#8592; Volver a la Lista</button>
      <h3 class="panel-title">Expediente del Empleado</h3>
      <button @click="exportToPDF" class="export-button" title="Exportar a PDF">📄 Exportar PDF</button>
    </div>
    <div class="panel-body" v-if="empleado">
      <!-- INFORMACIÓN PERSONAL -->
      <div class="employee-header">
        <div class="employee-avatar">
          {{ getInitials(empleado.primer_nombre, empleado.primer_apellido) }}
        </div>
        <div class="employee-basic-info">
          <h4>{{ getNombreCompleto(empleado) }}</h4>
          <p class="employee-id">Documento de Identidad: {{ empleado.doc_identidad }}</p>
          
          <!-- POSICIÓN ACTUAL INTEGRADA - SIMPLIFICADA -->
          <div v-if="empleadoSeleccionado && empleadoSeleccionado.posicion_actual" class="current-position-simple">
            <div v-if="empleadoSeleccionado.posicion_actual.activo" class="position-simple">
              <div class="position-role-simple">{{ empleadoSeleccionado.posicion_actual.cargo }}</div>
              <div class="position-location-simple">
                🏛️ {{ empleadoSeleccionado.posicion_actual.museo }}
                <span v-if="empleadoSeleccionado.posicion_actual.departamento">
                  • {{ empleadoSeleccionado.posicion_actual.departamento }}
                </span>
              </div>
            </div>
            <div v-else class="position-simple inactive">
              <div class="position-role-simple">Sin asignación actual</div>
              <div class="position-location-simple">🔘 Empleado no activo en ningún museo</div>
            </div>
          </div>
          
          <div class="employee-badges">
            <span v-if="empleado.fecha_nacimiento" class="badge badge-edad">{{ calcularEdad(empleado.fecha_nacimiento) }} años</span>
          </div>
        </div>
      </div>



      <!-- INFORMACIÓN DE CONTACTO -->
      <div class="info-section">
        <h5 class="section-title">📞 Información Personal</h5>
        <div class="info-grid">
          <div class="info-item" v-if="empleado.fecha_nacimiento">
            <span class="label">Fecha de Nacimiento:</span>
            <span class="value">{{ formatFecha(empleado.fecha_nacimiento) }}</span>
          </div>
          <div class="info-item" v-if="empleado.contacto">
            <span class="label">Teléfono:</span>
            <span class="value">{{ formatTelefono(empleado.contacto) }}</span>
          </div>
        </div>
      </div>

      <!-- SECCIÓN DE FORMACIÓN ACADÉMICA -->
      <div v-if="empleado.formaciones && empleado.formaciones.length" class="info-section">
        <h5 class="section-title">🎓 Formación Académica</h5>
        <div class="timeline">
          <div v-for="(formacion, index) in empleado.formaciones" :key="index" class="timeline-item">
            <div class="timeline-year">{{ formacion.anio }}</div>
            <div class="timeline-content">
              <strong>{{ formacion.titulo }}</strong>
              <p v-if="formacion.descripcion">{{ formacion.descripcion }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- SECCIÓN DE IDIOMAS -->
      <div v-if="empleado.idiomas && empleado.idiomas.length" class="info-section">
        <h5 class="section-title">🌐 Idiomas</h5>
        <div class="skills-tags">
          <span v-for="(idioma, index) in empleado.idiomas" :key="index" class="skill-tag">{{ idioma }}</span>
        </div>
      </div>

      <!-- SECCIÓN DE HISTORIAL DE MOVIMIENTOS EN MUSEOS -->
      <div v-if="empleado.historial && empleado.historial.length" class="info-section">
        <h5 class="section-title">🏛️ Historial de Movimientos en Museo</h5>
        <div class="timeline">
          <div v-for="(movimiento, index) in empleado.historial" :key="index" class="timeline-item movement-item">
            <div class="timeline-period">
              {{ formatAnio(movimiento.fecha_inicio) }}
              <br>
              <small>{{ movimiento.fecha_fin ? formatAnio(movimiento.fecha_fin) : 'Actual' }}</small>
            </div>
            <div class="timeline-content movement-content">
              <div class="movement-header">
                <strong class="movement-role">{{ movimiento.cargo }}</strong>
                <span v-if="!movimiento.fecha_fin" class="badge badge-current">Posición Actual</span>
              </div>
              <div class="movement-details">
                <p class="movement-museum">🏛️ <strong>{{ movimiento.museo }}</strong></p>
                <p v-if="movimiento.unidad" class="movement-department">🏢 {{ movimiento.unidad }}</p>
                <div class="movement-duration">
                  ⏱️ <strong>Duración:</strong> {{ calcularDuracionMovimiento(movimiento.fecha_inicio, movimiento.fecha_fin) }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
    <div v-else class="panel-body">
        <p>Cargando expediente del empleado...</p>
    </div>
  </div>
</template>

<script>
import jsPDF from 'jspdf';

export default {
  name: 'EmpleadoDet',
  props: {
    empleado: {
      type: Object,
      default: null
    },
    empleadoSeleccionado: {
      type: Object,
      default: null
    }
  },
  methods: {
    formatFecha(fechaString) {
      if (!fechaString) return '';
      try {
        const date = new Date(fechaString);
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Intl.DateTimeFormat('es-ES', options).format(date);
      } catch (e) {
        console.error("Error al formatear la fecha:", fechaString, e);
        return fechaString; 
      }
    },
    
    formatAnio(fechaString) {
      if (!fechaString) return '';
      try {
        const date = new Date(fechaString);
        return date.getFullYear();
      } catch (e) {
        console.error("Error al formatear el año:", fechaString, e);
        return fechaString; 
      }
    },
    
    formatTelefono(numero) {
      if (!numero) return '';
      const str = numero.toString();
      // Formato: +XX XXX XXX XXXX para números internacionales
      if (str.length >= 10) {
        return `+${str.substring(0, 2)} ${str.substring(2, 5)} ${str.substring(5, 8)} ${str.substring(8)}`;
      }
      return str;
    },
    
    getNombreCompleto(empleado) {
      const nombres = [
        empleado.primer_nombre,
        empleado.segundo_nombre,
        empleado.primer_apellido,
        empleado.segundo_apellido
      ].filter(Boolean);
      return nombres.join(' ');
    },
    
    getInitials(nombre1, apellido1) {
      const inicial1 = nombre1 ? nombre1.charAt(0).toUpperCase() : '';
      const inicial2 = apellido1 ? apellido1.charAt(0).toUpperCase() : '';
      return inicial1 + inicial2;
    },
    
    calcularEdad(fechaNacimiento) {
      if (!fechaNacimiento) return '';
      const hoy = new Date();
      const nacimiento = new Date(fechaNacimiento);
      let edad = hoy.getFullYear() - nacimiento.getFullYear();
      const diferenciaMeses = hoy.getMonth() - nacimiento.getMonth();
      
      if (diferenciaMeses < 0 || (diferenciaMeses === 0 && hoy.getDate() < nacimiento.getDate())) {
        edad--;
      }
      return edad;
    },

    calcularTiempoEnPosicion(fechaInicio) {
      if (!fechaInicio) return '';
      
      const inicio = new Date(fechaInicio);
      const ahora = new Date();
      const diffTime = Math.abs(ahora - inicio);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      
      if (diffDays < 30) {
        return `${diffDays} días`;
      } else if (diffDays < 365) {
        const meses = Math.floor(diffDays / 30);
        return `${meses} ${meses === 1 ? 'mes' : 'meses'}`;
      } else {
        const años = Math.floor(diffDays / 365);
        const mesesRestantes = Math.floor((diffDays % 365) / 30);
        if (mesesRestantes === 0) {
          return `${años} ${años === 1 ? 'año' : 'años'}`;
        }
        return `${años} ${años === 1 ? 'año' : 'años'} y ${mesesRestantes} ${mesesRestantes === 1 ? 'mes' : 'meses'}`;
      }
    },

    calcularDuracionMovimiento(fechaInicio, fechaFin) {
      if (!fechaInicio) return 'No especificado';
      
      const inicio = new Date(fechaInicio);
      const fin = fechaFin ? new Date(fechaFin) : new Date();
      const diffTime = Math.abs(fin - inicio);
      const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
      
      if (diffDays < 30) {
        return `${diffDays} días`;
      } else if (diffDays < 365) {
        const meses = Math.floor(diffDays / 30);
        return `${meses} ${meses === 1 ? 'mes' : 'meses'}`;
      } else {
        const años = Math.floor(diffDays / 365);
        const mesesRestantes = Math.floor((diffDays % 365) / 30);
        if (mesesRestantes === 0) {
          return `${años} ${años === 1 ? 'año' : 'años'}`;
        }
        return `${años} ${años === 1 ? 'año' : 'años'}, ${mesesRestantes} ${mesesRestantes === 1 ? 'mes' : 'meses'}`;
      }
    },


    
    async exportToPDF() {
      if (!this.empleado) return;
      
      try {
        const doc = new jsPDF();
        const empleado = this.empleado;
        
        // Configuración del documento
        doc.setFont('helvetica', 'bold');
        doc.setFontSize(20);
        
        // Título
        doc.text('EXPEDIENTE DE EMPLEADO PROFESIONAL', 20, 20);
        
        // Línea separadora
        doc.setLineWidth(0.5);
        doc.line(20, 25, 190, 25);
        
        // Información personal
        doc.setFontSize(16);
        doc.text('INFORMACIÓN PERSONAL', 20, 40);
        
        doc.setFont('helvetica', 'normal');
        doc.setFontSize(12);
        
        let y = 50;
        doc.text(`Nombre Completo: ${this.getNombreCompleto(empleado)}`, 20, y);
        y += 8;
        doc.text(`Documento de Identidad: ${empleado.doc_identidad}`, 20, y);
        y += 8;
        
        if (empleado.fecha_nacimiento) {
          doc.text(`Fecha de Nacimiento: ${this.formatFecha(empleado.fecha_nacimiento)} (${this.calcularEdad(empleado.fecha_nacimiento)} años)`, 20, y);
          y += 8;
        }
        
        if (empleado.contacto) {
          doc.text(`Teléfono: ${this.formatTelefono(empleado.contacto)}`, 20, y);
          y += 8;
        }
        
        y += 10;

        // Posición Actual
        if (this.empleadoSeleccionado && this.empleadoSeleccionado.posicion_actual) {
          doc.setFont('helvetica', 'bold');
          doc.setFontSize(16);
          doc.text('POSICIÓN ACTUAL', 20, y);
          y += 10;
          
          doc.setFont('helvetica', 'normal');
          doc.setFontSize(12);
          
          if (this.empleadoSeleccionado.posicion_actual.activo) {
            doc.text(`Cargo: ${this.empleadoSeleccionado.posicion_actual.cargo}`, 25, y);
            y += 6;
            doc.text(`Museo: ${this.empleadoSeleccionado.posicion_actual.museo}`, 25, y);
            y += 6;
            if (this.empleadoSeleccionado.posicion_actual.departamento) {
              doc.text(`Departamento: ${this.empleadoSeleccionado.posicion_actual.departamento}`, 25, y);
              y += 6;
            }
            if (this.empleadoSeleccionado.posicion_actual.fecha_inicio) {
              doc.text(`Desde: ${this.formatFecha(this.empleadoSeleccionado.posicion_actual.fecha_inicio)}`, 25, y);
              y += 6;
            }
          } else {
            doc.text('Estado: INACTIVO - Sin asignación actual', 25, y);
            y += 6;
          }
          
          y += 10;
        }
        
        // Formación Académica
        if (empleado.formaciones && empleado.formaciones.length > 0) {
          doc.setFont('helvetica', 'bold');
          doc.setFontSize(16);
          doc.text('FORMACIÓN ACADÉMICA', 20, y);
          y += 10;
          
          doc.setFont('helvetica', 'normal');
          doc.setFontSize(12);
          
          empleado.formaciones.forEach(formacion => {
            doc.text(`• ${formacion.titulo} (${formacion.anio})`, 25, y);
            y += 6;
            if (formacion.descripcion) {
              doc.setFontSize(10);
              doc.text(`  ${formacion.descripcion}`, 25, y);
              doc.setFontSize(12);
              y += 6;
            }
            y += 2;
          });
          
          y += 5;
        }
        
        // Idiomas
        if (empleado.idiomas && empleado.idiomas.length > 0) {
          doc.setFont('helvetica', 'bold');
          doc.setFontSize(16);
          doc.text('IDIOMAS', 20, y);
          y += 10;
          
          doc.setFont('helvetica', 'normal');
          doc.setFontSize(12);
          doc.text(`${empleado.idiomas.join(', ')}`, 25, y);
          y += 15;
        }
        
        // Historial de Movimientos
        if (empleado.historial && empleado.historial.length > 0) {
          doc.setFont('helvetica', 'bold');
          doc.setFontSize(16);
          doc.text('HISTORIAL DE MOVIMIENTOS EN MUSEO', 20, y);
          y += 10;
          
          doc.setFont('helvetica', 'normal');
          doc.setFontSize(12);
          
          empleado.historial.forEach(movimiento => {
            // Verificar si necesitamos una nueva página
            if (y > 250) {
              doc.addPage();
              y = 20;
            }
            
            doc.setFont('helvetica', 'bold');
            doc.text(`${movimiento.cargo}`, 25, y);
            y += 6;
            
            doc.setFont('helvetica', 'normal');
            doc.text(`Museo: ${movimiento.museo}`, 25, y);
            y += 6;
            if (movimiento.unidad) {
              doc.text(`Departamento: ${movimiento.unidad}`, 25, y);
              y += 6;
            }
            doc.text(`Período: ${this.formatAnio(movimiento.fecha_inicio)} - ${movimiento.fecha_fin ? this.formatAnio(movimiento.fecha_fin) : 'Actual'}`, 25, y);
            y += 6;
            doc.text(`Duración: ${this.calcularDuracionMovimiento(movimiento.fecha_inicio, movimiento.fecha_fin)}`, 25, y);
            y += 10;
          });


        }
        
        // Pie de página
        const fechaGeneracion = new Date().toLocaleDateString('es-ES');
        doc.setFontSize(8);
        doc.setTextColor(128, 128, 128);
        doc.text(`Expediente generado el ${fechaGeneracion}`, 20, 280);
        
        // Guardar el PDF
        const nombreArchivo = `Expediente_${empleado.primer_nombre}_${empleado.primer_apellido}_${empleado.doc_identidad}.pdf`;
        doc.save(nombreArchivo);
        
      } catch (error) {
        console.error('Error al generar PDF:', error);
        alert('Error al generar el PDF. Por favor, inténtelo de nuevo.');
      }
    }
  }
}
</script>

<style scoped>
.employee-details-panel {
  background-color: white;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.15);
  margin: 1rem 0;
  overflow: hidden;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  border: 1px solid rgba(255,255,255,0.2);
}

.panel-header {
  background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
  color: white;
  padding: 1.5rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  justify-content: space-between;
}

.back-button, .export-button {
  background: rgba(255,255,255,0.2);
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: all 0.2s ease;
  font-weight: 500;
}

.back-button:hover, .export-button:hover {
  background: rgba(255,255,255,0.3);
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.export-button {
  background: rgba(255,255,255,0.15);
}

.panel-title {
  color: white;
  margin: 0;
  font-weight: 600;
  font-size: 1.4rem;
  flex: 1;
}

.panel-body {
  padding: 2rem;
  color: #374151;
  line-height: 1.6;
}

/* EMPLOYEE HEADER */
.employee-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
  border-radius: 12px;
  border: 1px solid #e5e7eb;
}

.employee-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 2rem;
  font-weight: bold;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.employee-basic-info h4 {
  color: #1f2937;
  margin: 0 0 0.5rem 0;
  font-size: 1.8rem;
  font-weight: 700;
}

.employee-id {
  color: #6b7280;
  margin: 0 0 1rem 0;
  font-size: 1rem;
  font-weight: 500;
}

.employee-badges {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

/* POSICIÓN ACTUAL INTEGRADA DE FORMA NATURAL */
.current-position-simple {
  margin: 0.75rem 0 0 0;
}

.position-simple {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.position-role-simple {
  font-weight: 700;
  font-size: 1.2rem;
  color: #1f2937;
  margin: 0;
}

.position-location-simple {
  color: #3b82f6;
  font-weight: 500;
  font-size: 1rem;
  margin: 0;
}

.position-simple.inactive .position-role-simple {
  color: #6b7280;
}

.position-simple.inactive .position-location-simple {
  color: #9ca3af;
}

.badge {
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
}

.badge-edad {
  background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
  color: white;
}

.badge-current {
  background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
  color: white;
}

/* INFO SECTIONS */
.info-section {
  margin-bottom: 2rem;
  background: #f8fafc;
  padding: 1.5rem;
  border-radius: 12px;
  border-left: 4px solid #3b82f6;
}

.section-title {
  color: #1f2937;
  margin: 0 0 1.5rem 0;
  font-size: 1.3rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1rem;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem;
  background: white;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
}

.info-item .label {
  font-weight: 600;
  color: #374151;
}

.info-item .value {
  color: #1f2937;
  font-weight: 500;
}

/* TIMELINE STYLES */
.timeline {
  position: relative;
  padding-left: 1rem;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 2px;
  background: linear-gradient(180deg, #3b82f6 0%, #e5e7eb 100%);
}

.timeline-item {
  position: relative;
  display: flex;
  gap: 1.5rem;
  margin-bottom: 2rem;
  align-items: flex-start;
}

.timeline-item::before {
  content: '';
  position: absolute;
  left: -0.5rem;
  top: 0.5rem;
  width: 1rem;
  height: 1rem;
  border-radius: 50%;
  background: #3b82f6;
  border: 3px solid white;
  box-shadow: 0 0 0 3px #3b82f6;
}

.movement-item::before {
  background: #10b981;
  box-shadow: 0 0 0 3px #10b981;
}

.timeline-year, .timeline-period {
  min-width: 80px;
  font-weight: 600;
  color: #3b82f6;
  font-size: 0.9rem;
  text-align: center;
  background: white;
  padding: 0.5rem;
  border-radius: 6px;
  border: 1px solid #e5e7eb;
}

.timeline-content {
  flex: 1;
  background: white;
  padding: 1rem;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.timeline-content strong {
  color: #1f2937;
  font-size: 1.1rem;
  display: block;
  margin-bottom: 0.5rem;
}

/* MOVEMENT SPECIFIC STYLES */
.movement-content {
  border-left: 4px solid #10b981;
}

.movement-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.movement-role {
  color: #1f2937;
  font-size: 1.2rem;
}

.movement-details {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.movement-museum {
  color: #3b82f6;
  font-weight: 600;
  margin: 0;
}

.movement-department {
  color: #6b7280;
  margin: 0;
}

.movement-duration {
  color: #374151;
  font-size: 0.9rem;
  margin-top: 0.5rem;
  padding-top: 0.5rem;
  border-top: 1px solid #e5e7eb;
}



/* SKILLS TAGS */
.skills-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.skill-tag {
  background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 500;
  box-shadow: 0 2px 4px rgba(99, 102, 241, 0.3);
}

/* Responsive */
@media (max-width: 768px) {
  .panel-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
  
  .panel-body {
    padding: 1.5rem;
  }
  
  .panel-title {
    font-size: 1.2rem;
  }
  
  .employee-header {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }
  
  .employee-avatar {
    width: 60px;
    height: 60px;
    font-size: 1.5rem;
  }
  
  .info-grid {
    grid-template-columns: 1fr;
  }
  
  .timeline-item {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .timeline-year, .timeline-period {
    min-width: auto;
    align-self: flex-start;
  }

  .position-simple {
    gap: 0.5rem;
  }

  .movement-header {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
