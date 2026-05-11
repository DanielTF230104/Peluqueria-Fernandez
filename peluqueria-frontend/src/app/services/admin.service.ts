import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class AdminService {
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl + '/admin/usuarios';

  private getHeaders() {
    const token = localStorage.getItem('auth_token');
    return { headers: new HttpHeaders({ 'Authorization': `Bearer ${token}` }) };
  }

  getUsuarios(): Observable<any> {
    return this.http.get(this.apiUrl, this.getHeaders());
  }

  actualizarUsuario(id: number, datos: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}`, datos, this.getHeaders());
  }

  eliminarUsuario(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`, this.getHeaders());
  }

  getAllCitas(): Observable<any> {
    return this.http.get(environment.apiUrl + '/admin/citas', this.getHeaders());
  }
}