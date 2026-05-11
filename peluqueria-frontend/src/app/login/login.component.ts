import { Component, inject, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private authService = inject(AuthService);

  usuario = {
    email: '',
    password: ''
  };

  ngOnInit(): void {
    this.route.queryParams.subscribe(params => {
      if (params['verified'] === 'true') {
        alert('¡Correo verificado con éxito! Ya puedes iniciar sesión.');
      }
    });
  }

  login() {
    if (this.usuario.email && this.usuario.password) {
      this.authService.login(this.usuario).subscribe({
        next: (res: any) => {
          localStorage.setItem('auth_token', res.access_token);
          localStorage.setItem('user_data', JSON.stringify(res.user));
          alert(`¡Bienvenido de nuevo, ${res.user.name}!`);
          this.router.navigate(['/main']); 
        },
        error: (err) => {
          console.error('Error en el login:', err);
          if (err.status === 403) {
            alert('Debes verificar tu correo electrónico antes de acceder. Revisa tu bandeja de entrada.');
          } else {
            alert('Email o contraseña incorrectos. Inténtalo de nuevo.');
          }
        }
      });
    } else {
      alert('Por favor, rellena todos los campos');
    }
  }

  irRegistro() {
    this.router.navigate(['/registro']);
  }
}