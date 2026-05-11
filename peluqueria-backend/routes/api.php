<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CitaController;
use App\Http\Controllers\AdminController;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Auth\Events\Verified;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login'])->name('login');
Route::get('/citas/horas-ocupadas/{fecha}', [CitaController::class, 'horasOcupadas']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/citas', [CitaController::class, 'guardar']);
    Route::get('/citas/mis-citas', [CitaController::class, 'misCitas']);
    Route::put('/citas/{id}', [CitaController::class, 'actualizar']);
    Route::delete('/citas/{id}', [CitaController::class, 'eliminar']);

    Route::get('/admin/usuarios', [AdminController::class, 'listarUsuarios']);
    Route::put('/admin/usuarios/{id}', [AdminController::class, 'actualizarUsuario']);
    Route::delete('/admin/usuarios/{id}', [AdminController::class, 'eliminarUsuario']);
    Route::get('/admin/citas', [AdminController::class, 'listarTodasLasCitas']);
    Route::get('/citas/horas-ocupadas/{fecha}', [CitaController::class, 'getHorasOcupadas']);
    Route::get('/mis-citas', [CitaController::class, 'misCitas']);
});

Route::get('/email/verify/{id}/{hash}', function (Request $request, $id, $hash) {
    $user = User::find($id);

    if (! $request->hasValidSignature() || 
        ! $user || 
        ! hash_equals((string) $hash, sha1($user->getEmailForVerification()))) {
        return redirect('http://localhost:4200/verificar-email?status=error');
    }

    if ($user->hasVerifiedEmail()) {
        return redirect('http://localhost:4200/verificar-email?status=ya_verificado');
    }

    if ($user->markEmailAsVerified()) {
        event(new Verified($user));
    }

    return redirect('http://localhost:4200/verificar-email?status=exito');
})->middleware(['signed'])->name('verification.verify');