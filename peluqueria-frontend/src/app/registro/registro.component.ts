import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-registro',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.css']
})
export class RegistroComponent {
  private router = inject(Router);
  private authService = inject(AuthService);

  usuario = {
    name: '', 
    email: '',
    telefono: '',
    password: ''
  };

  registrar() {
    if (this.usuario.name && this.usuario.email && this.usuario.password) {
      this.authService.register(this.usuario).subscribe({
        next: (res: any) => {
          console.log('Respuesta del servidor:', res);
          alert(res.message || 'Cuenta creada. Por favor, verifica tu correo electrónico.');
          
          this.router.navigate(['/login']);
        },
        error: (err) => {
          console.error('Error al registrar:', err);
          alert('Hubo un error al crear la cuenta. Es posible que el email ya esté en uso.');
        }
      });
    } else {
      alert('Rellena todos los campos correctamente');
    }
  }

  irLogin() {
    this.router.navigate(['/login']);
  }
}