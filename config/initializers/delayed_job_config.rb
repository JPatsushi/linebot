Delayed::Worker.destroy_failed_jobs = false # 失敗したジョブをDBから削除しない=false）
Delayed::Worker.max_attempts = 3 # リトライ回数
Delayed::Worker.max_run_time = 5.minutes # 最大実行時間