import { Component, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CitasService } from '../services/citas.service';

@Component({
  selector: 'app-formulario',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './formulario.component.html',
  styleUrls: ['./formulario.component.css']
})
export class FormularioComponent implements OnInit {
  fechaMinima: string = '';
  horasPosibles: string[] = [
    '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', 
    '13:00', '13:30', '16:00', '16:30', '17:00', '17:30', 
    '18:00', '18:30', '19:00', '19:30', '20:00'
  ];
  horasOcupadas: string[] = [];
  private router = inject(Router);
  private citasService = inject(CitasService);

  form = {
    nombre: '',
    telefono: '',
    servicio: null as any,
    fecha: '',
    hora: '',
    observaciones: ''
  };

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

  ngOnInit(): void {
    const datosGuardados = localStorage.getItem('user_data');
    const hoy = new Date();
    this.fechaMinima = hoy.toISOString().split('T')[0];

    if (datosGuardados) {
      const usuario = JSON.parse(datosGuardados);

      this.form.nombre = usuario.name || '';
      this.form.telefono = usuario.telefono || '';
    }
  }

  guardarReserva() {
    if (!this.form.nombre || !this.form.telefono || !this.form.servicio || !this.form.fecha || !this.form.hora) {
      alert('Por favor, completa todos los campos obligatorios');
      return;
    }

    const reservaFinal = {
      nombre: this.form.nombre, 
      telefono: this.form.telefono,
      servicio: this.form.servicio.nombre,
      precio: this.form.servicio.precio,
      fecha: this.form.fecha,
      hora: this.form.hora,
      observaciones: this.form.observaciones
    };

    this.citasService.crearCita(reservaFinal).subscribe({
      next: () => {
        alert('¡Cita reservada con éxito!');
        this.router.navigate(['/perfil']);
      },
      error: (err) => {
        console.error('Error al guardar cita', err);
        alert('Hubo un problema al guardar la cita.');
      }
    });
  }

  alCambiarFecha() {
    if (this.form.fecha) {
      this.citasService.getHorasOcupadas(this.form.fecha).subscribe({
        next: (res: any) => {
          console.log('1. Datos brutos del servidor:', res);
          
          if (Array.isArray(res)) {
            this.horasOcupadas = res.map((h: string) => {
              return h ? h.substring(0, 5) : '';
            });
          } else {
            this.horasOcupadas = [];
          }
          
          console.log('2. Horas procesadas:', this.horasOcupadas);
          this.form.hora = '';
        },
        error: (err) => {
          console.error('Error en la petición:', err);
          this.horasOcupadas = []; 
        }
      });
    }
  }

  estaOcupada(hora: string): boolean {
    const reservada = this.horasOcupadas.includes(hora);
    if (reservada) return true;

    const ahora = new Date();
    
    const anio = ahora.getFullYear();
    const mes = String(ahora.getMonth() + 1).padStart(2, '0');
    const dia = String(ahora.getDate()).padStart(2, '0');
    const hoyStr = `${anio}-${mes}-${dia}`;

    if (this.form.fecha === hoyStr) {
      const [hCita, mCita] = hora.split(':').map(Number);
      const ahoraH = ahora.getHours();
      const ahoraM = ahora.getMinutes();

      if (hCita < ahoraH) return true;
      if (hCita === ahoraH && mCita <= ahoraM) return true;
    }

    return false;
  }

  volverInicio() {
    this.router.navigate(['/main']);
  }
}