output "state_bucket_name" {
  description = "Name of the S3 bucket for remote state — plug into backend.tf 'bucket'"
  value       = aws_s3_bucket.tf_state.id
}

output "lock_table_name" {
  description = "Name of the DynamoDB table for state locking — plug into backend.tf 'dynamodb_table'"
  value       = aws_dynamodb_table.tf_lock.name
}
