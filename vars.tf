variable "AWS_REGION" {
  default = "ap-northeast-1"
}
variable "AMIS" {
  type = map(string)
  default = {
    ap-northeast-1 = "ami-067871d950411e643"
    ap-northeast-2 = "ami-0b23bb3616e3892a6"
    ap-northeast-3 = "ami-0342c5dc12a7d4377" 
  }

}