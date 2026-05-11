import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AdminService } from '../services/admin.service';

@Component({
  selector: 'app-gestion-citas',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './gestion-citas.component.html',
  styleUrls: ['./gestion-citas.component.css']
})
export class GestionCitasComponent implements OnInit {
  citas: any[] = [];
  citasFiltradas: any[] = [];

  filtros = {
    nombre: '',
    servicio: '',
    fecha: '',
    hora: '',
    telefono: ''
  };

  private adminService = inject(AdminService);

  ngOnInit() {
    this.cargarTodasLasCitas();
  }

  cargarTodasLasCitas() {
    this.adminService.getAllCitas().subscribe({
      next: (res) => {
        this.citas = res;
        this.citasFiltradas = res;
      },
      error: (err) => console.error('Error al cargar todas las citas', err)
    });
  }

  aplicarFiltros() {
    this.citasFiltradas = this.citas.filter(cita => {
      const cumpleNombre = cita.nombre.toLowerCase().includes(this.filtros.nombre.toLowerCase());
      const cumpleServicio = cita.servicio.toLowerCase().includes(this.filtros.servicio.toLowerCase());
      const cumpleFecha = this.filtros.fecha ? cita.fecha === this.filtros.fecha : true;
      const cumpleTelefono = cita.telefono.includes(this.filtros.telefono);

      return cumpleNombre && cumpleServicio && cumpleFecha && cumpleTelefono;
    });
  }

  esPasada(fechaCita: string): boolean {
    const hoy = new Date().toISOString().split('T')[0];
    return fechaCita < hoy;
  }

  limpiarFiltros() {
    this.filtros = { nombre: '', servicio: '', fecha: '', hora: '', telefono: '' };
    this.citasFiltradas = [...this.citas];
  }
}