import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const authGuard: CanActivateFn = (route, state) => {
  console.log('--- EJECUTANDO GUARD ---');
  const router = inject(Router);
  const token = localStorage.getItem('auth_token');
  
  console.log('Token encontrado:', token);

  if (token) {
    return true;
  } else {
    console.log('No hay token, redirigiendo...');
    router.navigate(['/login']);
    return false;
  }
};