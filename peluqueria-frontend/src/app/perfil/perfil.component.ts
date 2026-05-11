import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CitasService } from '../services/citas.service';

@Component({
  selector: 'app-perfil',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './perfil.component.html',
  styleUrls: ['./perfil.component.css']
})
export class PerfilComponent implements OnInit {
  usuario: any = {};
  citas: any[] = [];
  editandoId: number | null = null;
  citaEditada: any = {};

  horasPosibles: string[] = [
    '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', 
    '13:00', '13:30', '16:00', '16:30', '17:00', '17:30', 
    '18:00', '18:30', '19:00', '19:30', '20:00'
  ];
  horasOcupadasEdicion: string[] = [];

  private citasService = inject(CitasService);

  servicios = [
    { nombre: 'Corte de pelo', precio: 12 },
    { nombre: 'Tinte', precio: 25 },
    { nombre: 'Corte de pelo + Tinte', precio: 32 },
    { nombre: 'Peinado', precio: 10 },
    { nombre: 'Corte + Tinte + Peinado', precio: 40 },
    { nombre: 'Arreglo de barba', precio: 8 },
    { nombre: 'Corte de pelo + Arreglo de barba', precio: 20 },
    { nombre: 'Pack completo', precio: 50 },
  ];

  ngOnInit() {
    const userData = localStorage.getItem('user_data');
    if (userData) {
      this.usuario = JSON.parse(userData);
    }
    this.cargarCitas();
  }

  cargarCitas() {
    this.citasService.getUserCitas().subscribe({
      next: (res) => {
        this.citas = res.sort((a: any, b: any) => {
          return new Date(b.fecha + ' ' + b.hora).getTime() - new Date(a.fecha + ' ' + a.hora).getTime();
        });
      },
      error: (err) => console.error(err)
    });
  }

  haPasadoMediaHora(cita: any): boolean {
    const ahora = new Date();
    
    const [anio, mes, dia] = cita.fecha.split('-').map(Number);
    const [hora, min] = cita.hora.split(':').map(Number);

    const fechaCita = new Date(anio, mes - 1, dia, hora, min);
    
    const fechaLimite = new Date(fechaCita.getTime() + 30 * 60000);

    console.log('--- COMPROBANDO CITA ---');
    console.log('Fecha Cita:', fechaCita.toLocaleString());
    console.log('Fecha Límite (Cita + 30min):', fechaLimite.toLocaleString());
    console.log('Hora Actual (Tu PC):', ahora.toLocaleString());
    console.log('¿Ha pasado?:', ahora > fechaLimite);

    return ahora > fechaLimite;
  }

  borrarCita(id: number) {
    if(confirm('¿Estás seguro de cancelar esta cita?')) {
      this.citasService.eliminarCita(id).subscribe({
        next: () => {
          alert('Cita cancelada');
          this.cargarCitas();
        },
        error: (err) => console.error(err)
      });
    }
  }

  activarEdicion(cita: any) {
    this.editandoId = cita.id;
    this.citaEditada = { ...cita }; 
    this.alCambiarFechaEdicion();
  }

  alCambiarFechaEdicion() {
    if (this.citaEditada.fecha) {
      this.citasService.getHorasOcupadas(this.citaEditada.fecha).subscribe({
        next: (res: any) => {
          this.horasOcupadasEdicion = res.map((h: string) => h.substring(0, 5));
        },
        error: (err) => console.error('Error al cargar horas ocupadas:', err)
      });
    }
  }

  estaOcupadaEdicion(hora: string): boolean {
    const citaOriginal = this.citas.find(c => c.id === this.editandoId);
    
    if (citaOriginal && citaOriginal.fecha === this.citaEditada.fecha && citaOriginal.hora.substring(0,5) === hora) {
      return false;
    }

    return this.horasOcupadasEdicion.includes(hora);
  }

  cancelarEdicion() {
    this.editandoId = null;
    this.citaEditada = {};
  }

  guardarEdicion(id: number) {
    if (this.estaOcupadaEdicion(this.citaEditada.hora)) {
      alert('Esa hora acaba de ser ocupada, por favor elige otra.');
      return;
    }

    this.citasService.actualizarCita(id, this.citaEditada).subscribe({
      next: () => {
        alert('Cita actualizada correctamente');
        this.editandoId = null;
        this.cargarCitas();
      },
      error: (err) => {
        const mensaje = err.error?.mensaje || 'Error al actualizar';
        alert(mensaje);
      }
    });
  }

  cambiarServicioEdicion(evento: any) {
    const servicioSeleccionado = this.servicios.find(s => s.nombre === evento.target.value);
    if (servicioSeleccionado) {
      this.citaEditada.servicio = servicioSeleccionado.nombre;
      this.citaEditada.precio = servicioSeleccionado.precio;
    }
  }
  
}