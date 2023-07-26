resource "aws_dynamodb_table" "tf_state_lock" {
    name    = "tfstate_lock"
    #파티션키
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    #키속성
    attribute {
      name = "LockID"
      type = "S"
    }
}

resource "aws_s3_bucket" "tf_state_bucket" {

    bucket = "tfbucket-230705"
  
}