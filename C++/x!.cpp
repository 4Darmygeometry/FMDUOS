#include <stdio.h>
#include <cmath>
int main(int argc, char *argv[]) {
	double x;
	if(argc==1){
		scanf("%lf",&x);
	}
	else{
		x=atof(argv[1]);
	}
	if(x<=19){
		double a=floor(tgamma(x+1));
		int b=(int)((tgamma(x+1)-floor(tgamma(x+1)))*100000000); 
		if(b==0) printf("%.0lf\n",a);
		else printf("%.15lf\n",tgamma(x+1));
	}
	else {
		printf("%.15lg\n",tgamma(x+1));
	}
	return 0;
}
