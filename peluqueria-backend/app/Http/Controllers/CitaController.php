<?php

namespace App\Http\Controllers;

use App\Models\Cita;
use Illuminate\Http\Request;

class CitaController extends Controller
{
    public function guardar(Request $request)
    {
        $user = $request->user();
        
        if (!$user) {
            return response()->json(['mensaje' => 'Debes estar autenticado para reservar.'], 401);
        }

        $existeCita = Cita::where('fecha', $request->fecha)
                        ->where('hora', $request->hora)
                        ->exists();

        if ($existeCita) {
            return response()->json(['mensaje' => 'Lo sentimos, esta hora ya ha sido reservada.'], 422);
        }

        $cita = Cita::create([
            'user_id' => $user->id,
            'nombre' => $request->nombre,
            'telefono' => $request->telefono,
            'servicio' => $request->servicio,
            'precio' => $request->precio,
            'fecha' => $request->fecha,
            'hora' => $request->hora,
            'observaciones' => $request->observaciones
        ]);

        return response()->json($cita);
    }

    public function horasOcupadas($fecha)
    {
        try {
            $horas = \App\Models\Cita::where('fecha', $fecha)
                        ->select('hora')
                        ->get()
                        ->pluck('hora')
                        ->toArray();

            return response()->json($horas, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function misCitas(Request $request)
    {
        $user = $request->user();
        
        if (!$user) {
            return response()->json(['error' => 'Usuario no encontrado'], 401);
        }

        $citas = Cita::where('user_id', $user->id)
                    ->orderBy('fecha', 'asc')
                    ->get();

        return response()->json($citas);
    }

    public function actualizar(Request $request, $id)
    {
        $cita = Cita::where('id', $id)->where('user_id', $request->user()->id)->first();

        if (!$cita) {
            return response()->json(['mensaje' => 'Cita no encontrada'], 404);
        }

        $ocupada = Cita::where('fecha', $request->fecha)
                        ->where('hora', $request->hora)
                        ->where('id', '!=', $id)
                        ->exists();

        if ($ocupada) {
            return response()->json(['mensaje' => 'Esta hora ya está reservada por otro cliente.'], 422);
        }

        $cita->update([
            'servicio' => $request->servicio,
            'precio'   => $request->precio,
            'fecha'    => $request->fecha,
            'hora'     => $request->hora,
        ]);

        return response()->json(['mensaje' => 'Cita actualizada', 'cita' => $cita]);
    }

    public function eliminar(Request $request, $id)
    {
        $cita = Cita::where('id', $id)->where('user_id', $request->user()->id)->first();

        if (!$cita) {
            return response()->json(['mensaje' => 'Cita no encontrada o no autorizada'], 404);
        }

        $cita->delete();

        return response()->json(['mensaje' => 'Cita cancelada correctamente']);
    }

}