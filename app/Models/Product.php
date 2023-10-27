<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',  // Add any other attributes you want to mass-assign here
        'description',
        'price',
        'type',
        'image'
        // Add more attributes as needed
    ];

    public function purchases()
    {
        return $this->hasMany(Purchase::class);
    }

}
