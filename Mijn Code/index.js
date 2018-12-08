var express = require("express");
var bodyParser = require("body-parser");
var mysql= require("mysql");
var session= require("express-session");

var app = express();

var credenciales = {
    user: "root",
    password: "",
    port:"3306",
    host:"localhost",
    database:"mydb",
}

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));

app.use(express.static("public"));
app.use(session({secret:"ASDFE$%#%",resave:true, saveUninitialized:true}));

var public_Usuario= express.static("public_Usuario");
app.use(
    function(req,res,next){
        if (req.session.nombre_usuario){
            //Significa que el usuario si esta logueado
			public_Usuario(req,res,next);
        }
        else
            return next();
    }
);


app.post("/login", function(req, res){
    var conexion = mysql.createConnection(credenciales);
    conexion.query('SELECT id_usuarios, nombre_usuario FROM mydb.tbl_usuarios WHERE usuario=? and contrasena=SHA1(?)',
        [req.body.usuario, req.body.contrasena],
        function(err, data, fields){
                if (data.length>0){
                    req.session.nombre_usuario = data[0].nombre_usuario;
                    req.session.id_usuarios = data[0].id_usuarios;
                    data[0].estatus = 0;
                    res.send(data[0]); 
                }else{
                    res.send({estatus:1, mensaje: "Login fallido"}); 
                }
         }
    ); 
});


app.post("/registro", function (req,res) {
    var conexion = mysql.createConnection(credenciales);
    conexion.query('INSERT INTO mydb.tbl_usuarios(nombre,apellido,correo,nombre_usuario,contrasena,imagen_perfil,id_planes) VALUES (?,?,?,?,SHA1(?),"img/perfil/avatar.png",1)',
                    [req.body.nombre, req.body.apellido, req.body.correo, req.body.nombre_usuario, req.body.contrasena],
                    function(err, result){
                        if (err) throw err;
                        res.send(result);
                    }
    );
    
})

app.listen(3000);
console.log("Servidor levantado, esperando conexiones");