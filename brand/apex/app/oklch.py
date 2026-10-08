import math
def s2l(c):
    c/=255; return c/12.92 if c<=0.04045 else ((c+0.055)/1.055)**2.4
def l2s(c):
    c = 12.92*c if c<=0.0031308 else 1.055*c**(1/2.4)-0.055
    return c
def hex2oklch(h):
    r,g,b=[s2l(int(h[i:i+2],16)) for i in (1,3,5)]
    l=0.4122214708*r+0.5363325363*g+0.0514459929*b
    m=0.2119034982*r+0.6806995451*g+0.1073969566*b
    s=0.0883024619*r+0.2817188376*g+0.6299787005*b
    l,m,s=[x**(1/3) for x in (l,m,s)]
    L=0.2104542553*l+0.7936177850*m-0.0040720468*s
    a=1.9779984951*l-2.4285922050*m+0.4505937099*s
    bb=0.0259040371*l+0.7827717662*m-0.8086757660*s
    return L, math.hypot(a,bb), math.degrees(math.atan2(bb,a))%360
def oklch2rgb(L,C,H):
    a=C*math.cos(math.radians(H)); b=C*math.sin(math.radians(H))
    l=L+0.3963377774*a+0.2158037573*b; m=L-0.1055613458*a-0.0638541728*b; s=L-0.0894841775*a-1.2914855480*b
    l,m,s=l**3,m**3,s**3
    r=4.0767416621*l-3.3077115913*m+0.2309699292*s
    g=-1.2684380046*l+2.6097574011*m-0.3413193965*s
    bl=-0.0041960863*l-0.7034186147*m+1.7076147010*s
    return r,g,bl
def ingamut(rgb): return all(-0.0005<=x<=1.0005 for x in rgb)
def oklch2hex(L,C,H):
    lo,hi=0,C
    if not ingamut(oklch2rgb(L,C,H)):
        for _ in range(40):
            mid=(lo+hi)/2
            if ingamut(oklch2rgb(L,mid,H)): lo=mid
            else: hi=mid
        C=lo
    r,g,b=oklch2rgb(L,C,H)
    return '#%02X%02X%02X'%tuple(max(0,min(255,round(l2s(max(0,min(1,x)))*255))) for x in (r,g,b))
def lum(h):
    r,g,b=[s2l(int(h[i:i+2],16)) for i in (1,3,5)]; return 0.2126*r+0.7152*g+0.0722*b
def contraste(a,b):
    la,lb=sorted([lum(a),lum(b)],reverse=True); return (la+0.05)/(lb+0.05)
