import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-verificar-email',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './verificar-email.component.html',
  styleUrls: ['./verificar-email.component.css']
})
export class VerificarEmailComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);

  titulo: string = 'Verificando...';
  mensaje: string = 'Por favor, espera un momento.';
  icono: string = '⏳';
  mostrarBotonLogin: boolean = false;

  ngOnInit(): void {
    this.route.queryParams.subscribe(params => {
      const status = params['status'];

      switch (status) {
        case 'exito':
          this.titulo = '¡Correo verificado!';
          this.mensaje = 'Tu cuenta ha sido activada correctamente. Ya puedes iniciar sesión y disfrutar de nuestros servicios.';
          this.icono = '✅';
          this.mostrarBotonLogin = true;
          break;
        case 'ya_verificado':
          this.titulo = 'Cuenta ya activa';
          this.mensaje = 'Este correo electrónico ya ha sido verificado anteriormente. Puedes ir directamente al login.';
          this.icono = 'ℹ️';
          this.mostrarBotonLogin = true;
          break;
        case 'error_firma':
          this.titulo = 'Enlace inválido';
          this.mensaje = 'Lo sentimos, este enlace de verificación es inválido o ha caducado. Por favor, solicita uno nuevo desde el login.';
          this.icono = '❌';
          this.mostrarBotonLogin = false;
          break;
        case 'error_hash':
          this.titulo = 'Error de seguridad';
          this.mensaje = 'Ha habido un problema de seguridad con el enlace. Por favor, solicita uno nuevo.';
          this.icono = '⚠️';
          this.mostrarBotonLogin = false;
          break;
        default:
          this.titulo = 'Algo ha salido mal';
          this.mensaje = 'No hemos podido verificar tu correo. Por favor, inténtalo de nuevo más tarde.';
          this.icono = '⁉️';
          this.mostrarBotonLogin = false;
      }
    });
  }

  irAlLogin() {
    this.router.navigate(['/login']);
  }
}