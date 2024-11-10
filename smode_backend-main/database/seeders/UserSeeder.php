<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            'email' => 'andd.fian@gmail.com',
            'password' => bcrypt('12345678'),
            'name' => 'Andi Alfian Bahtiar',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
