import { Component, OnInit, inject, HostListener } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  mostrarBotones = true;
  menuAbierto = false;
  scrolled = false;
  
  isAdmin = false; 
  
  private router = inject(Router);


  ngOnInit(): void {
    this.router.events.subscribe(event => {
      if (event instanceof NavigationEnd) {
        const ruta = this.router.url;

        this.mostrarBotones = !(
          ruta.includes('/login') || 
          ruta.includes('/registro') || 
          ruta.includes('/verificar-email')
        );

        if (this.mostrarBotones) {
          const userData = localStorage.getItem('user_data');
          if (userData) {
            const user = JSON.parse(userData);
            this.isAdmin = (user.role === 'admin');
          } else {
            this.isAdmin = false;
          }
        }
      }
    });
  }

  @HostListener('window:scroll', [])
  onWindowScroll() {
    this.scrolled = window.scrollY > 50;
  }

  reservar() {
    this.router.navigate(['/formulario']);
  }

  verPerfil() {
    this.router.navigate(['/perfil']);
  }

  irAdmin() {
    this.router.navigate(['/admin']);
  }

  cerrarSesion() {
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user_data');
    this.isAdmin = false;
    this.router.navigate(['/login']);
  }

  irAInicio() {
    this.router.navigate(['/main']);
  }

  toggleMenu() {
    this.menuAbierto = !this.menuAbierto;
  }

  cerrarMenu() {
    this.menuAbierto = false;
  }

  irGestionCitas() {
    this.router.navigate(['/admin/citas']);
  }
}