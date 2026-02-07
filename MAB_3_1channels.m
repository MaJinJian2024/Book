clc;
clear;

data2 = load('coupled_Il.mat');
data3 = load('coupled_I2.mat');
data4 = load('coupled_I3.mat');

Pt1 = data2.Pt1;
Pt2 = data3.Pt2;
Pt3 = data4.Pt3;
omega1=1;omega2=1;omega3=1;
for ii=1:100
    deltat=20;
    I11=Pt1(0.95e5:deltat:0.95e5+deltat*999);
    I21=Pt2(0.165e5:deltat:0.165e5+deltat*999);
    I31=Pt3(0.235e5:deltat:0.235e5+deltat*999);
    I1=I11/max(I11);
    I2=I21/max(I21);
    I3=I31/max(I31);
    s1=I1/max(I1)-0.5;
    s2=I2/max(I2)-0.5;
    s3=I3/max(I3)-0.5;
    % 初始化四组随机数
    random_numbers=vertcat(s1, s2, s3);
    % 初始化老虎机的奖励概率
    means = [0.2, 0.2, 0.2, 0.8, 0.2, 0.2, 0.2, 0.2];
    % 初始化四组阈值
    thresholds = zeros(3, length(random_numbers));
    % 初始化成功次数
    successes = zeros(3, length(random_numbers));
    a=0.99;
    delta=1;
    % omega1=1;omega2=1;omega3=1;
    % 对每组随机数和阈值进行比较
    ND10=0;ND20=0;ND30=0;
    ND11=0;ND21=0;ND31=0;
    for j = 1:1000
        if random_numbers(1, j) > thresholds(1,j)
            successes(1,j) = 1;
        else
            successes(1,j) = 0;
        end

        if random_numbers(2, j) > thresholds(2,j)
            successes(2,j) = 1;
        else
            successes(2,j) = 0;
        end

        if random_numbers(3, j) > thresholds(3,j)
            successes(3,j) = 1;
        else
            successes(3,j) = 0;
        end

        if rand()<means(bin2dec((dec2bin(successes(:,j)'))')+1)
            % 获得奖励
            if all(isequal(successes(1, j), 0))
                ND10=ND10+1;
                thresholds(1,j+1)=delta+a*thresholds(1,j);
            else
                ND11=ND11+1;
                thresholds(1,j+1)=-delta+a*thresholds(1,j);
            end

            if all(isequal(successes(2, j), 0))
                ND20=ND20+1;
                thresholds(2,j+1)=delta+a*thresholds(2,j);
            else
                ND21=ND21+1;
                thresholds(2,j+1)=-delta+a*thresholds(2,j);
            end

            if all(isequal(successes(3, j), 0))
                ND30=ND30+1;
                thresholds(3,j+1)=delta+a*thresholds(3,j);
            else
                ND31=ND31+1;
                thresholds(3,j+1)=-delta+a*thresholds(3,j);
            end
        else
            % 未获得奖励
            if all(isequal(successes(1, j), 0))
                thresholds(1,j+1)=-omega1+a*thresholds(1,j);
            else
                thresholds(1,j+1)=omega1+a*thresholds(1,j);
            end

            if all(isequal(successes(2, j), 0))
                thresholds(2,j+1)=-omega2+a*thresholds(2,j);
            else
                thresholds(2,j+1)=omega2+a*thresholds(2,j);
            end

            if all(isequal(successes(3, j), 0))
                thresholds(3,j+1)=-omega3+a*thresholds(3,j);
            else
                thresholds(3,j+1)=omega3+a*thresholds(3,j);
            end
        end
    end
    PD10=ND10/sum(successes(1,:)==0);PD11=ND11/sum(successes(1,:)==1);
    PD20=ND20/sum(successes(2,:)==0);PD21=ND21/sum(successes(2,:)==1);
    PD30=ND30/sum(successes(3,:)==0);PD31=ND31/sum(successes(3,:)==1);
    omega1=PD10+PD11;omega2=PD20+PD21;omega3=PD30+PD31;

    for j=1:1000
        result1(1,j)=bin2dec((dec2bin(successes(:,j)'))')+1;
        [m,p]=max(means);
        CDR(j)=sum(result1(1:j)==p)/j;
    end
    CDR1(ii,:)=CDR;
end
meanc1=mean(CDR1,1);
meancdr1=smooth(meanc1',10);
%%
omega1=1;omega2=1;omega3=1;
for ii=1:100
    deltat=20;
    I11=Pt1(0.5e5:deltat:0.5e5+deltat*999);
    I21=Pt1(0.6e5:deltat:0.6e5+deltat*999);
    I31=Pt1(0.7e5:deltat:0.7e5+deltat*999);
    I1=I11/max(I11);
    I2=I21/max(I21);
    I3=I31/max(I31);
    s1=I1/max(I1)-0.5;
    s2=I2/max(I2)-0.5;
    s3=I3/max(I3)-0.5;
    % 初始化四组随机数
    random_numbers=vertcat(s1, s2, s3);
    % 初始化老虎机的奖励概率
    means = [0.2, 0.2, 0.2, 0.8, 0.2, 0.2, 0.2, 0.2];
    % 初始化四组阈值
    thresholds = zeros(3, length(random_numbers));
    % 初始化成功次数
    successes = zeros(3, length(random_numbers));
    a=0.99;
    delta=1;
    % omega1=1;omega2=1;omega3=1;
    % 对每组随机数和阈值进行比较
    ND10=0;ND20=0;ND30=0;
    ND11=0;ND21=0;ND31=0;
    for j = 1:1000
        if random_numbers(1, j) > thresholds(1,j)
            successes(1,j) = 1;
        else
            successes(1,j) = 0;
        end

        if random_numbers(2, j) > thresholds(2,j)
            successes(2,j) = 1;
        else
            successes(2,j) = 0;
        end

        if random_numbers(3, j) > thresholds(3,j)
            successes(3,j) = 1;
        else
            successes(3,j) = 0;
        end

        if rand()<means(bin2dec((dec2bin(successes(:,j)'))')+1)
            % 获得奖励
            if all(isequal(successes(1, j), 0))
                ND10=ND10+1;
                thresholds(1,j+1)=delta+a*thresholds(1,j);
            else
                ND11=ND11+1;
                thresholds(1,j+1)=-delta+a*thresholds(1,j);
            end

            if all(isequal(successes(2, j), 0))
                ND20=ND20+1;
                thresholds(2,j+1)=delta+a*thresholds(2,j);
            else
                ND21=ND21+1;
                thresholds(2,j+1)=-delta+a*thresholds(2,j);
            end

            if all(isequal(successes(3, j), 0))
                ND30=ND30+1;
                thresholds(3,j+1)=delta+a*thresholds(3,j);
            else
                ND31=ND31+1;
                thresholds(3,j+1)=-delta+a*thresholds(3,j);
            end
        else
            % 未获得奖励
            if all(isequal(successes(1, j), 0))
                thresholds(1,j+1)=-omega1+a*thresholds(1,j);
            else
                thresholds(1,j+1)=omega1+a*thresholds(1,j);
            end

            if all(isequal(successes(2, j), 0))
                thresholds(2,j+1)=-omega2+a*thresholds(2,j);
            else
                thresholds(2,j+1)=omega2+a*thresholds(2,j);
            end

            if all(isequal(successes(3, j), 0))
                thresholds(3,j+1)=-omega3+a*thresholds(3,j);
            else
                thresholds(3,j+1)=omega3+a*thresholds(3,j);
            end
        end
    end
    PD10=ND10/sum(successes(1,:)==0);PD11=ND11/sum(successes(1,:)==1);
    PD20=ND20/sum(successes(2,:)==0);PD21=ND21/sum(successes(2,:)==1);
    PD30=ND30/sum(successes(3,:)==0);PD31=ND31/sum(successes(3,:)==1);
    omega1=PD10+PD11;omega2=PD20+PD21;omega3=PD30+PD31;

    for j=1:1000
        result2(1,j)=bin2dec((dec2bin(successes(:,j)'))')+1;
        [m,p]=max(means);
        CDR(j)=sum(result2(1:j)==p)/j;
    end
    CDR2(ii,:)=CDR;
end
meanc2=mean(CDR2,1);
meancdr2=smooth(meanc2',10);
%%
% figure
% % set(gcf,'Position',[800,400,600,500]);
% plot(meancdr1,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','r','MarkerSize', 3)
% hold on
% plot(meancdr2,'LineWidth',1.5,'Color','b','Marker','*','MarkerSize', 3)
% xlabel('Cycle')
% ylabel('CDR')
% axis([0 1000 0 1])
% set(gca, 'Linewidth', 1.5, 'FontSize', 15, 'FontWeight', 'bold', 'FontName', 'Times New Roman')
% grid off
% legend('Three channels','One channel','Location', 'SouthEast')
% % text( 'string',"(a)", 'Units','normalized','position',[0.02,0.92],'FontSize',20,'FontWeight','Bold','FontName','Times New Roman');

% figure
% plot(result1,'o','LineWidth',1.5,'Color','k')
% xlabel('Cycle')
% ylabel('Number')
% axis([0 300 1 8])
% set(gca,'Linewidth',1.5,'FontSize',15,'FontWeight','bold','FontName','Times new Roman')

figure
plot(result2,'o','LineWidth',1.5,'Color','k')
xlabel('Cycle')
ylabel('Number')
axis([0 300 1 8])
set(gca,'Linewidth',1.5,'FontSize',15,'FontWeight','bold','FontName','Times new Roman')