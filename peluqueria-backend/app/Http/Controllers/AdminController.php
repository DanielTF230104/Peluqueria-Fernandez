<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Cita; 
use Illuminate\Http\Request;

class AdminController extends Controller
{
    private function checkAdmin($user) {
        if ($user->role !== 'admin') {
            abort(403, 'Acceso denegado: No eres administrador.');
        }
    }

    public function listarUsuarios(Request $request)
    {
        $this->checkAdmin($request->user());
        return response()->json(User::all());
    }

    public function actualizarUsuario(Request $request, $id)
    {
        $this->checkAdmin($request->user());
        
        $usuario = User::findOrFail($id);
        $usuario->update([
            'name' => $request->name,
            'email' => $request->email,
            'telefono' => $request->telefono,
            'role' => $request->role
        ]);

        return response()->json(['mensaje' => 'Usuario actualizado', 'usuario' => $usuario]);
    }

    public function eliminarUsuario(Request $request, $id)
    {
        $this->checkAdmin($request->user());
        
        $usuario = User::findOrFail($id);
        $usuario->delete();

        return response()->json(['mensaje' => 'Usuario eliminado correctamente']);
    }

    public function listarTodasLasCitas(Request $request)
    {
        $this->checkAdmin($request->user());
        
        return response()->json(
            Cita::orderBy('fecha', 'desc')
                ->orderBy('hora', 'desc')
                ->get()
        );
    }
}