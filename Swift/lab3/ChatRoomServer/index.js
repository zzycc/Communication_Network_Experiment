var portNumber = 3000;
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var socketArray = [];
var nameArray = [];

//設定從網頁連進Server時，回傳index.html給瀏覽器 (瀏覽器端為Client，index.html裡面有client的code)
app.get('/',
        function(req, res)
        {
            res.sendFile(__dirname + '/index.html');
        });

//設定 Server 監聽 3000 這個 port
http.listen(portNumber,
            function()
            {
                console.log('listening on *:' + portNumber);
            });

//可將 io 視為 Server 上管理所有 Socket 的 Manager
io.on('connection',
      function(socket) /*[1]*/
      {
      
        socket.on('user send out message', /*[2]*/
                  function(msg)
                  {
                  var socketIndex;
                  for(var i=0 ; i<socketArray.length; i++){
                  if(socketArray[i] == socket)
                  socketIndex = i;
                  }                  //only send message back to the client of this socket ( with event string 'show message on screen' )
                  //socket.emit('show message on screen', '== server got your message == : '+ msg);
                  socket.emit('show message on screen', nameArray[socketIndex]+" : "+ msg);                  //broadcast to everyone include the client of this socket ( with event string 'event string' ), you can define 'event string' your self
                  //io.emit('event string', '== server to every client == ' + msg);
                  
                  //broadcast to everyone except for the client of this socket ( with event string 'event string' ), you can define 'event string' your self
                  //socket.broadcast.emit('show message on screen', '== server to other client == ' + msg);
                  socket.broadcast.emit('show message on screen', nameArray[socketIndex]+" : " + msg);                  });
      socket.on('send_name',function(name){
                nameArray[nameArray.length] = name;
                var nameString = nameArray.join('\n');
                io.emit('show_name',nameString);
                });
        socketArray[socketArray.length] = socket;
        console.log('socket count: '+socketArray.length);
        socket.on('disconnect',
                    function()
                    {
                  
                        //尋找要斷線的socket在socketArray中的index
                  var socketIndex;
                  for(var i=0 ; i<socketArray.length; i++){
                    if(socketArray[i] == socket)
                    socketIndex = i;
                  }
                  //從socketArray 中把斷線的socket移除
                  socketArray.splice(socketIndex,1);
                  nameArray.splice(socketIndex,1);
                  var nameString = nameArray.join('\n');
                  io.emit('show_name',nameString);
                  
                  //在server的console中輸出現有的socket數量
                  console.log('socket count: '+socketArray.length);
                  });
      });

/*
[1] when a new clinet connect to server, server will deploy a new socket to handle the connection to this client and call this function with the new created socket as parameter.

[2] tells socket to handle 'chat message from clinet' event. when socket get 'chat message frome clinet' event, server will call following function and the event message as the parameter
 
*/
