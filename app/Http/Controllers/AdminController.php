<?php

namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function getUserList()
    {
        $user = auth()->user();

        if($user->role === 'admin'){

            $users = User::all();
            return response($users,200);
        }else{
            return response(['message' => "You don't have an admin permission."], 422);
        }
    }
    public function accessCancel(Request $request)
    {
        $authUser = auth()->user();
    
        if($authUser->role === 'admin') {
            $userId = $request->input('user_id');
            $user = User::find($userId);
    
            if (!$user) {
                return response()->json(['message' => 'User not found'], 404);
            }
    
            $status = $request->input('status');
            $user->status = $status;
            $user->save();
    
            return response($user, 200);
        } else {
            return response(['message' => 'Unauthorized'], 403);
        }
    }
    
}
