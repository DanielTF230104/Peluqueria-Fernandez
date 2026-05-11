import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-main',
  imports: [],
  templateUrl: './main.component.html',
  styleUrl: './main.component.css'
})
export class MainComponent {
  indiceActual = 0;
  intervalo: any;
  modoOscuro = false;

  imagenes = [
    { src: 'corte.png', texto: 'Cortes modernos y clásicos' },
    { src: 'tinte.png', texto: 'Tintes profesionales' },
    { src: 'barba.png', texto: 'Arreglo de barba' },
    { src: 'peinado.png', texto: 'Peinados para eventos' }
  ];

  constructor(private router: Router) {}

  ngOnInit(): void {
    this.iniciarCarrusel();
  }

  ngOnDestroy(): void {
    clearInterval(this.intervalo);
  }

  iniciarCarrusel() {
    this.intervalo = setInterval(() => {
      this.siguiente();
    }, 4000);
  }

  siguiente() {
    this.indiceActual = (this.indiceActual + 1) % this.imagenes.length;
  }

  anterior() {
    this.indiceActual = (this.indiceActual - 1 + this.imagenes.length) % this.imagenes.length;
  }

  reservar() {
    this.router.navigate(['/formulario']);
  }

  cambiarTema() {
    this.modoOscuro = !this.modoOscuro;
    document.body.classList.toggle('dark', this.modoOscuro);
  }
}