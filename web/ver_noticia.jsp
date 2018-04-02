<%@page import="java.util.regex.Pattern"%>
<%@page import="Conexion.Conexion"%>
<%@page import="modelo.noticias"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Kandire</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

         <!--FAVICON -->
        <link rel="shortcut icon" href="img/favicon.png">
        <!-- CSS -->
	<link rel="stylesheet" href="bower_components/jquery-ui/themes/dark-hive/jquery-ui.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/cs-select.css">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/nanoscroller.css">
        <link rel="stylesheet" href="css/owl.carousel.css">
        <link rel="stylesheet" href="css/flexslider.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/presets/preset1.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link id="preset" rel="stylesheet" type="text/css" href="css/presets/preset1.css">

        <%

            Conexion con = new Conexion();
            int id_noticia = Integer.parseInt(request.getParameter("id_noticia"));
            JSONObject obj = new noticias(con).buscar(id_noticia);
            new noticias(con).suma_vistos(id_noticia);
	    String pat=obj.getJSONArray("fotos").getJSONObject(0).getString("foto");
            String fotourl=pat;
            out.println("<meta property='og:image' content='http://kandire.bo/"+pat+"'/>");
            String foto[] = pat.split(Pattern.quote("."));
            pat = foto[foto.length-1];
            out.println("<meta property='og:image:type' content='image/"+pat+"'/>");
            out.println("<meta property='og:url' content='http://kandire.bo/ver_noticia.jsp?id_noticia="+id_noticia+"'/>");
            out.println("<meta property='og:type' content='article'/>");
            out.println("<meta property='og:description' content='"+obj.getString("subtitulo")+"'/>");
            out.println("<meta property='og:title' content='"+obj.getString("titulo")+"'/>");
            out.println("<link rel='canonical' href='http://kandire.bo/ver_noticia.jsp?id_noticia="+id_noticia+"'/>");
	    con.Close();
        %>	
    </head>
    <body class="sticky-header">
        <div class="body-innerwrapper">
		<img title="" alt="" src="img/play.png" style='display:none;' id='img_mostrar'/>
		<img title="Escuchar Noticia" alt="" onclick="leer();" src="img/play.png" style="background: none !important; opacity: 0.7; cursor: pointer; top: 10%; left: 60%; border: 0px ;width: 80px; height: 80px; position: fixed;z-index: 9999;" class="ui-widget-content" id="draggable"/>
            <!--==================================
            =            START Header            =
            ===================================-->
            <header>
                <!-- top-bar -->
                <div id="newedge-top-bar">
                    <div class="container">
                        <div class="row">
                            <div style="text-align:center;padding:10px">
                                <img style="max-width:100%;max-height:100%" src="img/Banner%20850%20X%20100.gif" />
                            </div>
                        </div>
                        <div class="row">
                            <div id="logo" class="col-xs-4 col-sm-3 col-md-3 hidden-sm hidden-xs">
                                <a href="index.html"><img src="img/logo.png" alt="logo"></a>
                            </div>
                            <!-- //logo -->
                            <div class="col-sm-12 col-md-9">
                                <div class="top-right">
                                    <div class="newedge-date">
                                        <span class="fecha"></span>
                                    </div>
                                    <div class="newedge-date">
                                        <!-- www.tutiempo.net - Ancho:98px - Alto:40px -->
                                        <div id="TT_yha1kE1EEfC9fcFAKfqDzDjzD7lAaf2"></div>
                                        <script type="text/javascript" src="https://www.tutiempo.net/s-widget/l_yha1kE1EEfC9fcFAKfqDzDjzD7lAaf2"></script>
                                    </div> <!-- //date -->
                                    <!-- //language -->
                                    <div class="newedge-login">
                                        <a href="#" role="button" data-toggle="modal" data-target="#login">
                                            <i class="fa fa-user"></i>
                                        </a>
                                        <!-- Login modal -->
                                        <div id="login" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" onclick="login();" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>
                                                        <h1 class="text-left">Ingresar</h1>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="#" method="post" id="login-form">
                                                            <fieldset class="userdata">
                                                                <input id="username" placeholder="Usuario" type="text" name="username" class="form-control">
                                                                <input id="password" type="password" placeholder="Contrase�a" name="password" class="form-control">
                                                                <div class="remember-wrap">
                                                                    <input id="remember" type="checkbox" name="remember" class="inputbox" value="yes">
                                                                    <label for="remember">recordarme</label>
                                                                </div>
                                                                <div class="button-wrap pull-left">
                                                                    <input type="button" onclick="login();" name="Submit" class="btn btn-block btn-success" value="Ingresar">
                                                                </div>                                                                
                                                            </fieldset>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="newedge-search">
                                        <div class="search-icon-wrapper">
                                            <i class="fa fa-search"></i>
                                        </div>
                                        <div class="search-wrapper">
                                            <form action="#" method="post">
                                                <input name="searchword" maxlength="200" class="inputboxnewedge-top-search" type="text" size="20" placeholder="Buscar ...">
                                                <i id="search-close" class="fa fa-close"></i>
                                            </form>
                                        </div> <!-- //search-wrapper -->
                                    </div> <!-- //search -->
                                </div> <!-- //top-right -->
                            </div>
                        </div> <!-- //row -->
                    </div> <!-- //container -->
                </div> <!-- //top-bar -->
                <!-- navigation mobile version -->
                <div id="mobile-nav-bar" class="mobile-nav-bar">
                    <div class="container">
                        <div class="row">
                            <div class="visible-sm visible-xs col-sm-12">
                                <div id="logo" class="mobile-logo pull-left">
                                    <a href="index.html"><img src="img/logo.png" alt="logo"></a>
                                </div>
                                <a id="offcanvas-toggler" class="pull-right" href="#"><i class="fa fa-bars"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <nav id="navigation-bar" class="navigation hidden-sm hidden-xs">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12">
                                <ul class="list-inline megamenu-parent">
                                    <li class="active"><a href="index.html">Inicio</a></li>
                                    <li class="has-child menu-justify">
                                        <a href="#">Noticia</a>
                                        <div class="dropdown-inner container dropdown-menu-full-wrapper">
                                            <div class="dropdown-menu-full vertical-tabs">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <ul class="tab-btns" role="tablist" style="background-color:black">
                                                                    <li class="active"><a href="#Nacional" data-toggle="tab">Nacional</a></li>
                                                                    <li><a href="#Local" data-toggle="tab">Local</a></li>
                                                                    <li><a href="#Mundo" data-toggle="tab">Mundo</a></li>
                                                                    <li><a href="#Cultura" data-toggle="tab">Cultura</a></li>
                                                                </ul>
                                                            </div> <!-- //col-sm-3 -->
                                                            <div class="col-sm-9">
                                                                <div class="tab-content simple-article-overlay">
                                                                    <div role="tabpanel" class="tab-pane active" id="Nacional">
                                                                        <!-- traer las ultimas noticias -->
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#"></a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                          
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                          
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Local">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                          
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                           
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                         
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Mundo">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                           
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Cultura">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#"></a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="dribble">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="g-plus">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                </div> <!-- //tab-content -->
                                                            </div> <!-- //col-sm-9 -->
                                                        </div> <!-- //row -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="has-child menu-justify">
                                        <a href="#">Deportes</a>
                                        <div class="dropdown-inner container dropdown-menu-full-wrapper">
                                            <div class="dropdown-menu-full vertical-tabs">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <ul class="tab-btns" role="tablist" style="background-color:black">
                                                                    <li class="active"><a href="#Nacional" data-toggle="tab">Futbol</a></li>
                                                                    <li><a href="#Motores" data-toggle="tab">Motores</a></li>
                                                                    <li><a href="#Multideporte" data-toggle="tab">Multideporte</a></li>
                                                                </ul>
                                                            </div> <!-- //col-sm-3 -->
                                                            <div class="col-sm-9">
                                                                <div class="tab-content simple-article-overlay">
                                                                    <div role="tabpanel" class="tab-pane active" id="Futbol">
                                                                        <!-- traer las ultimas noticias -->
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Motores">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Multideporte">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->

                                                                </div> <!-- //tab-content -->
                                                            </div> <!-- //col-sm-9 -->
                                                        </div> <!-- //row -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="has-child menu-justify">
                                        <a href="#">Sociales</a>
                                        <div class="dropdown-inner container dropdown-menu-full-wrapper">
                                            <div class="dropdown-menu-full vertical-tabs">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <ul class="tab-btns" role="tablist" style="background-color:black">
                                                                    <li class="active"><a href="#Entrevista" data-toggle="tab">Entrevista</a></li>
                                                                    <li><a href="#Actualidad" data-toggle="tab">Actualidad</a></li>
                                                                    <li><a href="#TV" data-toggle="tab">TV</a></li>
                                                                    <li><a href="#Moda" data-toggle="tab">Moda</a></li>
                                                                    <li><a href="#Personaje" data-toggle="tab">Personaje</a></li>
                                                                    <li><a href="#Musica" data-toggle="tab">Musica</a></li>
                                                                </ul>
                                                            </div> <!-- //col-sm-3 -->
                                                            <div class="col-sm-9">
                                                                <div class="tab-content simple-article-overlay">
                                                                    <div role="tabpanel" class="tab-pane active" id="Entrevista">
                                                                        <!-- traer las ultimas noticias -->
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Actualidad">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="TV">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Moda">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Personaje">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Musica">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                </div> <!-- //tab-content -->
                                                            </div> <!-- //col-sm-9 -->
                                                        </div> <!-- //row -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="has-child menu-justify">
                                        <a href="#">Tendencias</a>
                                        <div class="dropdown-inner container dropdown-menu-full-wrapper">
                                            <div class="dropdown-menu-full vertical-tabs">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <ul class="tab-btns" role="tablist" style="background-color:black">
                                                                    <li class="active"><a href="#Medioambiente" data-toggle="tab">Medio Ambiente</a></li>
                                                                    <li><a href="#Educacion" data-toggle="tab">Educacion</a></li>
                                                                    <li><a href="#Cocina" data-toggle="tab">Cocina</a></li>
                                                                    <li><a href="#Salud" data-toggle="tab">Salud</a></li>
                                                                    <li><a href="#Tecnologia" data-toggle="tab">Tecnologia</a></li>
                                                                </ul>
                                                            </div> <!-- //col-sm-3 -->
                                                            <div class="col-sm-9">
                                                                <div class="tab-content simple-article-overlay">
                                                                    <div role="tabpanel" class="tab-pane active" id="Medioambiente">
                                                                        <!-- traer las ultimas noticias -->
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Educacion">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Cocina">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Salud">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                    <div role="tabpanel" class="tab-pane" id="Tecnologia">
                                                                        <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <article class="item">
                                                                                    <div class="article-inner">
                                                                                        <div class="overlay"></div>
                                                                                        <div class="img-wrapper"><img class="img-100p latest-post-image" src="" alt="img"></div>
                                                                                        <div class="post-share-social">
                                                                                            <a href="#" class="fa fa-facebook"></a>
                                                                                            <a href="#" class="fa fa-twitter"></a>
                                                                                            
                                                                                            <div class="share-icon"><i class="fa fa-share-alt"></i></div>
                                                                                        </div> <!-- //post-share-social -->
                                                                                        <div class="article-info">
                                                                                            <h4 class="entry-title">
                                                                                                <a href="#">Proin suscipit luctus orci placerat fringilla</a>
                                                                                            </h4>
                                                                                        </div>
                                                                                    </div>
                                                                                </article>
                                                                            </div>
                                                                        </div> <!-- //row -->
                                                                    </div> <!-- //tab-pane -->
                                                                </div> <!-- //tab-content -->
                                                            </div> <!-- //col-sm-9 -->
                                                        </div> <!-- //row -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div> <!-- col-sm-12 -->
                        </div> <!-- //row -->
                    </div> <!-- //container -->
                </nav>
                <!-- //navigation -->
            </header>
            <!--====  End of Header  ====-->
            <!--==================================
            =            START PAGE TITLE        =
            ===================================-->
            <section id="page-title">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-wrapper">
                            <div class="container">
                                <h2 class="pull-left title" style="color:red" id="subcategorianoticia"><%                                    
                                    String pri = obj.getString("subcat").substring(0,1);	     
                                    out.print("<span class='cat-icon'>"+pri+"</span>"+obj.getString("subcat"));
                                %> <span class="cat-icon"></span></h2>
                                <!-- breadcrumb 
                                <ol class="breadcrumb pull-right">
                                    <li><a style="color:red" href="index.html">Inicio</a></li>
                                    <li><a style="color:yellow" href="#" id="categorianoticia2"></a></li>
                                    <li style="color:green" class="active" id="subcategorianoticia2"></li>
                                </ol>  //breadcrumb -->
                            </div> <!-- //container -->
                        </div> <!-- //page-title-wrapper -->
                    </div>
                </div> <!-- //row -->
            </section>
            <!--====  End of PAGE TITLE  ====-->
            <!--==================================
            =            START MAIN WRAPPER      =
            ===================================-->
            <section class="main-wrapper single-category">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h4 id="titulo" class="main-entry-title"><%out.print(obj.getString("titulo"));%></h4>
                                    <p id="subtitulo" style="font-family:'Times New Roman'; font-size:x-large">
                                        <%out.print(obj.getString("subtitulo"));%>
                                    </p>
                                    <img src="<%out.print(fotourl);%>" id="img_portada" class="img-100p" alt="img">

                                    <!--<p  style="font-family:Times New Roman; text-align: justify; font-size:x-large">-->
                                    <p>
                                        <span id="descripcionfoto"><%out.print(obj.getJSONArray("fotos").getJSONObject(0).getString("descripcion"));%></span>
                                    </p>
                                    <p id="fuente"><b>Fuente :</b><i id="fuente_i"><%out.print(obj.getString("fuente"));%></i> </p>

                                    <div class="entry-blog-meta">
                                        <div class="entry-blog-meta-list">

                                            <div class="author-avatar-text">
                                                <p class="author" id="lugar"><%out.print(obj.getString("lugar"));%><a href="#" title="Posts by NewEdge" rel="author"></a></p>
                                                <span id="fecha" class="entry-date"><time><%out.print(obj.getString("fecha"));%></time></span>,
                                                <span id="categoria" class="cats"><%out.print(obj.getString("subcat"));%><a href="#" rel="category tag"></a></span>
                                            </div>
                                        </div> <!-- //entry-blog-meta-list -->

                                        <div class="entry-blog-meta-list">
                                            <div class="share-count">
                                                <span id="vistas" class="number"><%out.print(obj.getString("vistos"));%></span><span>Visitas</span>
                                            </div>
                                            <div class="newedge-social-share">
                                                <ul>
                                                    <li id="compartir_fb">
                                                        <a class='icon-facebook'  href='javascript: void(0);' onclick='mi_shared(<%out.print(id_noticia+"");%>);'><i class='fa fa-facebook'></i>Compartir en Facebook</a>
                                                    </li>
                                                    <li id="compartir_twiter">
							<a  class="icon-twitter"  href='javascript: void(0);' onclick='mi_sharedt(<%out.print(id_noticia+"");%>);'><i class="fa fa-twitter"></i>Tweet en Twitter</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="entry-summary" id='descripcion'>
                                       <%
                                                out.println("<p style='text-align:justify'>");
                                                out.println(obj.getString("descripcion"));
                                                out.println("</p>");
                                       %>    
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="advertisement mtb30 mtt30">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <iframe max-width="100%" height="315" src="https://www.youtube.com/embed/TsXRdVjXJnY" frameborder="0" allowfullscreen></iframe>
                                    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-sm-12">
                                        <iframe max-width="100%" height="315" src="https://www.youtube.com/embed/FreKOIpKKNU" frameborder="0" allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>

                            <div id="fb-root"></div>
                            <div class="social-counter clearfix">
                                <div class="section-title">
                                    <h3> <span class="cat-icon"><i class="fa fa-share-alt"></i></span>Mantente Conectado</h3>
                                </div> <!-- //section-title -->
                                <div class="fb-page" data-href="https://www.facebook.com/www.kandire.bo/" data-tabs="timeline" data-width="350" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="https://www.facebook.com/www.kandire.bo/" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/www.kandire.bo/">Kandire.bo</a></blockquote></div>
                            </div>
                            
                            <div class="newedge-twitter mtt30">
                                <h4 class="title">Twitter kandire.bo</h4>
                                <a class="twitter-timeline" href="https://twitter.com/hashtag/kandire.bo" data-widget-id="904012138469056514">Tweets sobre #kandire.bo</a>
                                <script>!function (d, s, id) {
                                    var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
                                    if (!d.getElementById(id)) {
                                        js = d.createElement(s);
                                        js.id = id;
                                        js.src = p + "://platform.twitter.com/widgets.js";
                                        fjs.parentNode.insertBefore(js, fjs);
                                    }
                                }(document, "script", "twitter-wjs");</script>
                            </div> <!-- //newedge-twitter -->

                            <div class="newedge-twitter mtt30">
                                <div class="section-title">
                                    <h3> <span class="cat-icon"><i class="fa fa-bell-o"></i></span>Clima</h3>
                                </div>
                                <!-- www.tutiempo.net - Ancho:241px - Alto:364px -->
                                <!-- www.tutiempo.net - Ancho:224px - Alto:359px -->
                                <div id="TT_yyD1EEkE1SQFnhrK7fzjDzDzjYlKMKrlLtkdEcCoq1DE1E1kE">El tiempo - Tutiempo.net</div>
                                <script type="text/javascript" src="https://www.tutiempo.net/s-widget/l_yyD1EEkE1SQFnhrK7fzjDzDzjYlKMKrlLtkdEcCoq1DE1E1kE"></script>

                            </div>
                        </div>
                    </div> <!-- //row -->
                </div> <!-- //container -->
            </section>
            <!--====  End of MAIN WRAPPER  ====-->
            <!--==================================
            =            START FOOTER            =
            ===================================-->
            <footer>
                <div class="footer-wrapper">
                    <div class="container">
                        <div class="row">
                            <div id="bottom1" class="col-sm-6 col-md-3">
                                <p class="footer-logo"><img src="img/logo.png" alt="logo"></p>
                                <p class="footer-info">Medio de comunicaci&oacute;n con el prop&oacute;sito de ayudar en la construcci&oacute;n de una Nueva Bolivia, con su labor de informar con objetividad y opinar con libertad.</p>

                                <div class="footer-contact">
                                    <p>
                                        <span>Email:</span>
					<a href="mailto:info@kandire.bo">info@kandire.bo</a>
                                    </p>
                                    <p>
                                        <span>Telefono:</span>
                                        33 251102
                                    </p>
                                </div>
                            </div> <!-- //bottom1 -->

                            <div id="bottom2" class="col-sm-6 col-md-3">
                                <div class="bottom-menu">
                                    
                                </div>
                            </div> <!-- //bottom2 -->

                            <div id="bottom3" class="col-sm-6 col-md-3">
                                <div class="">
                                    
                                </div>
                            </div> <!-- //bottom3 -->

                            <div id="bottom4" class="col-sm-6 col-md-3">
                                <div class="social-wrapper">
                                    <h3 class="title">Social Link</h3>
                                    <ul class="social-icons">
                                        <li><a target="_blank" href="https://www.facebook.com/www.kandire.bo"><i class="fa fa-facebook"></i> Facebook</a></li>
                                        <li><a target="_blank" href="https://twitter.com/hashtag/kandire.bo"><i class="fa fa-twitter"></i> Twitter</a></li>
                                    </ul>
                                </div>
                            </div> <!-- //bottom4 -->
                        </div> <!-- //row -->
                    </div>  <!-- //container -->
                </div> <!-- //footer-wrapper -->

                <div class="copyright-wrapper">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <p class="copyright"> Copyright � 2017 <a href="http://servisis.com.bo/">Kandire.</a> Derechos Reservados.</p>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <p class="pull-right">Design &amp; Devleopment by&nbsp;<a href="http://www.servisis.com.bo/">Servisis</a></p>
                            </div>
                        </div>  <!-- //row -->
                    </div> <!-- //container -->
                </div> <!-- //copyright-wrapper -->
            </footer>
            <!--====  End of FOOTER  ====-->
            <!-- Offcanvas Start-->
            <div class="offcanvas-overlay"></div>
            <div class="offcanvas-menu visible-sm visible-xs">
                <a href="#" class="close-offcanvas"><i class="fa fa-remove"></i></a>
                <div class="offcanvas-inner">
                    <h3 class="title">Buscar</h3>
                    <div class="search">
                        <form action="#" method="post">
                            <input name="searchword" maxlength="200" class="inputbox search-query" type="text" placeholder="Buscar ...">
                        </form>
                    </div>
                    <ul>
                        <li><a href="index.html">Inicio</a></li>
                        <li class="active">
                            <a href="index.html">Noticias</a>
                            <span role="button" class="offcanvas-menu-toggler collapsed" data-toggle="collapse" data-target="#collapse-menu-01" aria-expanded="false" aria-controls="collapse-menu-01"><i class="fa fa-plus"></i><i class="fa fa-minus"></i></span>
                            <ul class="collapse" id="collapse-menu-01" aria-expanded="false">
                                <li class="active"><a href="index.html">Nacional</a></li>
                                <li class="active"><a href="index.html">Local</a></li>
                                <li class="active"><a href="index.html">Mundo</a></li>
                                <li class="active"><a href="index.html">Cultura</a></li>
                            </ul>
                        </li>
                        <li class="active">
                            <a href="index.html">Deportes</a>
                            <span role="button" class="offcanvas-menu-toggler collapsed" data-toggle="collapse" data-target="#collapse-menu-01" aria-expanded="false" aria-controls="collapse-menu-01"><i class="fa fa-plus"></i><i class="fa fa-minus"></i></span>
                            <ul class="collapse" id="collapse-menu-01" aria-expanded="false">
                                <li class="active"><a href="index.html">Futbol</a></li>
                                <li class="active"><a href="index.html">Motores</a></li>
                                <li class="active"><a href="index.html">Multideportes</a></li>
                            </ul>
                        </li>
                        <li class="active">
                            <a href="index.html">Sociales</a>
                            <span role="button" class="offcanvas-menu-toggler collapsed" data-toggle="collapse" data-target="#collapse-menu-01" aria-expanded="false" aria-controls="collapse-menu-01"><i class="fa fa-plus"></i><i class="fa fa-minus"></i></span>
                            <ul class="collapse" id="collapse-menu-01" aria-expanded="false">
                                <li class="active"><a href="index.html">Entrevista</a></li>
                                <li class="active"><a href="index.html">Actualidad</a></li>
                                <li class="active"><a href="index.html">Tv</a></li>
                                <li class="active"><a href="index.html">Moda</a></li>
                                <li class="active"><a href="index.html">Personaje</a></li>
                                <li class="active"><a href="index.html">Musica</a></li>
                            </ul>
                        </li>
                        <li class="active">
                            <a href="index.html">Tendencias</a>
                            <span role="button" class="offcanvas-menu-toggler collapsed" data-toggle="collapse" data-target="#collapse-menu-01" aria-expanded="false" aria-controls="collapse-menu-01"><i class="fa fa-plus"></i><i class="fa fa-minus"></i></span>
                            <ul class="collapse" id="collapse-menu-01" aria-expanded="false">
                                <li class="active"><a href="index.html">Medio Ambiente</a></li>
                                <li class="active"><a href="index.html">Educacion</a></li>
                                <li class="active"><a href="index.html">Cocina</a></li>
                                <li class="active"><a href="index.html">Salud</a></li>
                                <li class="active"><a href="index.html">Tecnologia</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- end Offcanvas -->

        </div> <!-- //body-innerwrapper -->
        <!--/.style-chooser-->

        <script src="js/jquery.min.js"></script>
	<script src="js/lector.js" type="text/javascript"></script>
        <script src="js/lector-min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js"></script>
	<script src="bower_components/jquery-ui/jquery-ui.js"></script>
        <script src="bower_components/jquery-ui/jquery-ui-touch.js"></script>
        <script src="js/smoothscroll.js"></script>        
        <script src="js/classie.js"></script>
        <script src="js/selectFx.js"></script>        
        <script src="js/jquery.nanoscroller.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.flexslider-min.js"></script>        
        <script src="js/jquery.sticky.js"></script>        
        <script src="js/main.js"></script>
        <script src="js/switcher.js"></script>
        <script src="js_ppl/ver_noticia.js"></script>
	<script src="js_ppl/facebook.js" type="text/javascript"></script>
    </body>    
</html>
