#include <stdio.h>
#include <cmath>
int main(int argc, char *argv[]) {
	double a;
	if(argc==1){
		scanf("%lf",&a);
	}
	else{
		a=atof(argv[1]);
	}
	if(a==1) printf("1\n");
	else if(a==2) printf("2\n");
	else if(a==6) printf("3\n");
	else if(a==24) printf("4\n");
	else if(a==120) printf("5\n");
	else if(a==720) printf("6\n");
	else if(a==5040) printf("7\n");
	else if(a==40320) printf("8\n");
	else if(a==362880) printf("9\n");
	else if(a==3628800) printf("10\n");
	else if(a==39916800) printf("11\n");
	else if(a==479001600) printf("12\n");
	else if(a==6227020800) printf("13\n");
	else if(a==87178291200) printf("14\n");
	else if(a==1307674368000) printf("15\n");
	else if(a==20922789888000) printf("16\n");
	else if(a==355687428096000) printf("17\n");
	else if(a==6402373705728000) printf("18\n");
	else if(a==121645100408832000) printf("19\n");
	else {
		if(a>0.8856031944108 && a<1) {
			int i=1;
			double x=1;
			for(;i<=40;++i){
			x=x-(pow(10,-5)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-5))-tgamma(x+1));	
			}	
			printf("%.15lf\n",x);
		}
		else if(a>1 && a<2) {
			int i=1;
			double x=2;
			for(;i<=40;++i){
			x=x-(pow(10,-6)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-6))-tgamma(x+1));	
			}	
			printf("%.15lf\n",x);
		}
		else if(a>2 && a<6) {
			int i=1;
			double x=3;
			for(;i<=40;++i){
			x=x-(pow(10,-7)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-7))-tgamma(x+1));	
			}	
			printf("%.15lf\n",x);
		}
		else if(a>6 && a<24) {
			int i=1;
			double x=4;
			for(;i<=40;++i){
			x=x-(pow(10,-8)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-8))-tgamma(x+1));	
			}	
			printf("%.15lf\n",x);
		}
		else if(a>24 && a<120) {
			int i=1;
			double x=5;
			for(;i<=40;++i){
			x=x-(pow(10,-9)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-9))-tgamma(x+1));	
			}	
			printf("%.15lf\n",x);
		}
		else if(a>120 && a<720) {
			int i=1;
			double x=6;
			for(;i<=40;++i){
			x=x-(pow(10,-10)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-10))-tgamma(x+1));	
			}	
			printf("%.15lf\n",x);
		}
		else if(a>720 && a<5040) {
			int i=1;
			double x=7;
			for(;i<=40;++i){
			x=x-(pow(10,-11)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-11))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>5040 && a<40320) {
			int i=1;
			double x=8;
			for(;i<=40;++i){
			x=x-(pow(10,-12)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-12))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>40320 && a<362880) {
			int i=1;
			double x=9;
			for(;i<=40;++i){
			x=x-(pow(10,-13)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-13))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>362880 && a<3628800) {
			int i=1;
			double x=10;
			for(;i<=40;++i){
			x=x-(pow(10,-14)*(tgamma(x+1)-a))/(tgamma(x+1+pow(10,-14))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>3628800 && a<39916800) {
			int i=1;
			double x=11;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>39916800 && a<479001600) {
			int i=1;
			double x=12;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>479001600 && a<6227020800) {
			int i=1;
			double x=13;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>6227020800 && a<87178291200) {
			int i=1;
			double x=14;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>87178291200 && a<1307674368000) {
			int i=1;
			double x=15;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>1307674368000 && a<20922789888000) {
			int i=1;
			double x=16;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>20922789888000 && a<355687428096000) {
			int i=1;
			double x=17;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>355687428096000 && a<6402373705728000) {
			int i=1;
			double x=18;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else if(a>6402373705728000 && a<121645100408832000) {
			int i=1;
			double x=19;
			for(;i<=40;++i){
			x=x-(pow(10,-15)*(tgamma(x+1)-a))/(tgammal(x+1+pow(10,-15))-tgamma(x+1));
			}
			printf("%.15lf\n",x);
		}
		else printf("数字应位于(0.885603194410889,121645100408832000]\n");
	}
	return 0;
}
