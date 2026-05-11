import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AdminService } from '../services/admin.service';

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {
  usuarios: any[] = [];
  editandoId: number | null = null;
  usuarioEditado: any = {};
  idAdminLogueado: number | null = null; 
  private adminService = inject(AdminService);

  ngOnInit() {
    const userData = localStorage.getItem('user_data');
    if (userData) {
      this.idAdminLogueado = JSON.parse(userData).id;
    }
    this.cargarUsuarios();
  }

  cargarUsuarios() {
    this.adminService.getUsuarios().subscribe({
      next: (res) => this.usuarios = res,
      error: (err) => alert('No tienes permisos para ver esto')
    });
  }

  borrarUsuario(id: number) {
    if(confirm('¿Estás seguro de eliminar a este usuario permanentemente?')) {
      this.adminService.eliminarUsuario(id).subscribe({
        next: () => this.cargarUsuarios(),
        error: (err) => console.error(err)
      });
    }
  }

  activarEdicion(user: any) {
    this.editandoId = user.id;
    this.usuarioEditado = { ...user };
  }

  guardarEdicion(id: number) {
    this.adminService.actualizarUsuario(id, this.usuarioEditado).subscribe({
      next: () => {
        alert('Usuario actualizado');
        this.editandoId = null;
        this.cargarUsuarios();
      },
      error: (err) => console.error(err)
    });
  }
}