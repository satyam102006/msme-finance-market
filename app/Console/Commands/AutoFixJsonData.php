<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Helpers\DataValidator;

class AutoFixJsonData extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'data:fix-json {--force : Force fix even if files are valid}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Automatically fix JSON data files to prevent undefined array key errors';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('🔧 Starting automatic JSON data validation and fixing...');

        $files = [
            'offers.json' => 'Offers',
            'bids.json' => 'Bids',
            'msme_profile.json' => 'MSME Profile',
            'rfps.json' => 'RFPs',
            'msmes.json' => 'MSMEs List'
        ];

        $fixedCount = 0;
        $totalCount = 0;

        foreach ($files as $filename => $description) {
            $filepath = storage_path('app/json/' . $filename);
            
            if (!file_exists($filepath)) {
                $this->warn("⚠️  File not found: {$filename}");
                continue;
            }

            $totalCount++;
            $this->info("📄 Processing {$description} ({$filename})...");

            try {
                $data = json_decode(file_get_contents($filepath), true);
                
                if ($data === null) {
                    $this->error("❌ Invalid JSON in {$filename}");
                    continue;
                }

                // Validate and fix the data
                $validatorMethod = 'validate' . str_replace(['.json', 'msme_profile', 'msmes'], ['', 'MsmeProfile', 'Msmes'], $filename);
                $validatorMethod = str_replace('_', '', $validatorMethod);
                
                if (method_exists(DataValidator::class, $validatorMethod)) {
                    $validatedData = DataValidator::$validatorMethod($data);
                    
                    // Check if data was actually fixed
                    $originalJson = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                    $fixedJson = json_encode($validatedData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                    
                    if ($originalJson !== $fixedJson || $this->option('force')) {
                        file_put_contents($filepath, $fixedJson);
                        $this->info("✅ Fixed {$description} - {$filename}");
                        $fixedCount++;
                    } else {
                        $this->info("✅ {$description} is already valid - {$filename}");
                    }
                } else {
                    $this->warn("⚠️  No validator method found for {$filename}");
                }

            } catch (\Exception $e) {
                $this->error("❌ Error processing {$filename}: " . $e->getMessage());
            }
        }

        $this->newLine();
        $this->info("🎉 JSON data validation complete!");
        $this->info("📊 Summary: {$fixedCount} files fixed out of {$totalCount} processed");
        
        if ($fixedCount > 0) {
            $this->info("✅ All undefined array key errors should now be prevented!");
        } else {
            $this->info("✅ All files were already valid!");
        }

        return 0;
    }
} 