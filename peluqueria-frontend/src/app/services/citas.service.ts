import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CitasService {
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl + '/citas';
  
  private getHeaders() {
    const token = localStorage.getItem('auth_token');
    return { headers: new HttpHeaders({ 'Authorization': `Bearer ${token}` }) };
  }

  getHorasOcupadas(fecha: string): Observable<string[]> {
    const token = localStorage.getItem('auth_token');
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });

    return this.http.get<string[]>(`${this.apiUrl}/horas-ocupadas/${fecha}`, { headers });
  }

  crearCita(cita: any): Observable<any> {
    return this.http.post(this.apiUrl, cita, this.getHeaders());
  }

  getCitasUsuario(): Observable<any> {
    return this.http.get(this.apiUrl, this.getHeaders());
  }

  actualizarCita(id: number, cita: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}`, cita, this.getHeaders());
  }

  eliminarCita(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`, this.getHeaders());
  }

  getUserCitas(): Observable<any[]> {
    const token = localStorage.getItem('auth_token');
    
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });

    return this.http.get<any[]>(`${this.apiUrl}/mis-citas`, { headers });
  }
}