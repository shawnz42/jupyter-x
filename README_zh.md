# jupyter-x
Your can practice javascript, c++ more than python in jupyter notebook.


- kernels
![kernels](kernels.png)

- javascript example
![kernels](javascript.png)

- cpp example
![kernels](cpp17.png)

- steps
```angular2
docker build . -t jupyterx
docker run -it --name jupyterx -p $YOUR_HOST_PORT:9999 -v $YOUR_HOST_DIR:/notebooks -d jupyterx
```

- 
```angular2
如果在windows中使用第一代的dockertool box要在docker shell中挂载路径，不然不会写入宿主机，而是在virtulbox里面
docker run -it --name jupyterx -p 9999:9999 -v /c/Users/user/workplace/jupyternotebooks/:/notebooks -d jupyterx
```