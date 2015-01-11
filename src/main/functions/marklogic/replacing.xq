let $string := ')  as   xs:string'
return fn:replace($string, '&#xA0;', '')