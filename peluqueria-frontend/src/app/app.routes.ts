import { Routes } from '@angular/router';
import { MainComponent } from './main/main.component';
import { FormularioComponent } from './formulario/formulario.component';
import { LoginComponent } from './login/login.component';
import { RegistroComponent } from './registro/registro.component';
import { authGuard } from './guards/auth.guard';
import { PerfilComponent } from './perfil/perfil.component';
import { AdminComponent } from './admin/admin.component';
import { GestionCitasComponent } from './gestion-citas/gestion-citas.component';
import { VerificarEmailComponent } from './verificar-email/verificar-email.component';

export const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'registro', component: RegistroComponent },
  { path: 'verificar-email', component: VerificarEmailComponent },
  { 
    path: 'formulario', 
    component: FormularioComponent, 
    canActivate: [authGuard] 
  },
  { 
    path: 'main', 
    component: MainComponent, 
    canActivate: [authGuard] 
  },
  { 
    path: 'perfil', 
    component: PerfilComponent, 
    canActivate: [authGuard] 
  },
  { 
    path: 'admin', 
    component: AdminComponent, 
    canActivate: [authGuard] 
  },
  { 
    path: 'admin/citas', 
    component: GestionCitasComponent, 
    canActivate: [authGuard] 
  },
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: '**', redirectTo: 'login' }
];