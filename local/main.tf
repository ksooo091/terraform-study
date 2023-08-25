resource "local_file" "abc" {
  count = 2
  content  = count.index
  filename = "${path.module}/abc${count.index}.txt"
}
# resource "local_file" "def" {
#   content = local_file.abc.content
#   filename = "${path.module}/def.txt"
  
# }