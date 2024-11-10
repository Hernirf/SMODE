<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VehicleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('vehicles')->insert([
            'owner_id' => 1,
            'merk' => 'Honda',
            'plate' => 'KT 1234 ABC',
            'image' => 'motor.jpg',
            'lat' => '-0.4695437',
            'lon' => '117.1494175',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
