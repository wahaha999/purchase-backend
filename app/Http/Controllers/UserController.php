<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function signup(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:6|max:50',
        ]);

        if ($validator->fails()) {
            $errors = $validator->errors();
            return response(['message' => $errors->first()], 422); // 422 Unprocessable Entity
        }

        $user = User::create([
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            'password' => bcrypt($request->input('password')),
        ]);


        return response()->json(
            [
                "status" => 1,
                "message" => "User registered successfully"
            ],
            200
        );
    }

    public function login(Request $request)
    {
        // validation
        $request->validate([
            "email" => "required|email",
            "password" => "required"
        ]);
        // verify user + token
        if (!$token = auth()->attempt(["email" => $request->email, "password" => $request->password])) {
            return response()->json([
                "status" => 0,
                "message" => "Invalid credentials"
            ]);
        }

        $user = auth()->user();
        if($user->status === "0") {
            return response()->json([
                "status" => 0,
                "message" => "Invalid credentials"
            ]);
        }
        // send response
        return response()->json([
            "status" => 1,
            "message" => "Logged in successfully",
            "token" => $token,
            'data' => $user
        ]);
    }

    public function me()
    {
        $user = auth()->user();
        return response($user, 200);
    }
}
