#include <stdio.h>
#include <math.h>
int main(int argc, char *argv[]) {
	double a; 
	const double PI=3.14159265358979323846;
	const double E=2.71828182845904523536;
	if(argc==1){
		scanf("%lf",&a);
	}
	else{
		sscanf(argv[1],"%lf",&a);
	}
	if(a>1.5){
		int i=1;
		double x=(logl(a)*logl(a)+1)/(logl(a)+1);
		for(;i<=40;++i){
			x=(x*x+a*expl(-x))/(x+1);
		}
		printf("%.15lf\n",x);
	}
	else if(a>-0.367879441171442&&a<=1.5){
		int i=1;
		int j=1;
		double x=(logl((E-E/12.106633558745045)*a+1))/(logl(12.106633558745045));
		double x1=x;
		double x2=x;
		for(;i<=30;++i){
			x1=(x1*x1+a*expl(-x1))/(x1+1);
		}
		for(;j<=30;++j){
			x2=(x2*x2+a*powl(E,-x2))/(x2+1);
		}
		x=(0.729447*x1+1.270553*x2)/2;
		printf("%.15lf\n",x);
	}
	else if(a>=-0.367879441171443&&a<=-0.367879441171442){
		int x=-1;
		printf("%d\n",x);
	}
	else printf("该函数定义域为[-1/e,+∞)!\n");
	return 0;
}
