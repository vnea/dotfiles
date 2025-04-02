return {
    "mistweaverco/kulala.nvim",
    opts = {
        global_keymaps = true,
    },
    ft = { "http" }
}

--[[ Examples
###

POST https://dummy.restapiexample.com/api/v1/create
content-type: application/json

{
  "name": "test",
  "salary": "123",
  "age": "23"
}

###

POST https://dummy.restapiexample.com/api/v1/create
content-type: application/json

< new-dummy.json

###

GET https://dummy.restapiexample.com/api/v1/employees
accept: application/json

###

GET https://google.com

###
]]
