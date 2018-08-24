%%% Display setting and output setup
scr = get(groot,'ScreenSize');                              % screen resolution
phi = (1 + sqrt(5))/2;
ratio = 1.5*phi/3;
offset = [ scr(3)/8 scr(4)/8]; 
fig1 =  figure('Position',...                               % draw figure
        [offset(1) offset(2) scr(3)*ratio scr(4)*ratio]);
set(fig1,'numbertitle','off',...                            % Give figure useful title
        'name','Lab 1 - Exercise 1b',...
        'Color','white',...
        'Units','normalized',...
        'visible','off');
fontName='Helvetica';
set(0,'defaultAxesFontName', fontName);                     % Make fonts pretty
set(0,'defaultTextFontName', fontName);
set(groot,'FixedWidthFontName', 'ElroNet Monospace')  

%% Colors and formatting
nice_blue =     [ 0.180     0.180     0.900     0.6 ];
nice_green =    [ 0.180     0.900     0.180     0.6 ];
nice_cyan =     [ 0.180     0.900     0.900     0.6 ];
nice_yellow =   [ 0.900     0.900     0.180     0.6 ];
nice_red =      [ 0.900     0.180     0.180     0.6 ];
pastel_blue =   [ 0.0000    0.4470    0.7410    0.8 ];
trans_blue =    [ 0.0000    0.4470    0.7410    0.15 ];
pastel_orange = [ 0.8500    0.3250    0.0980    0.8 ];
pastel_yellow = [ 0.9290    0.6940    0.1250    0.8 ];
pastel_purple = [ 0.4940    0.1840    0.5560    0.8 ];
pastel_green =  [ 0.4660    0.6740    0.1880    0.8 ];
sky_blue =      [ 0.3010    0.7450    0.9330    0.8 ];
brick_red =     [ 0.6350    0.0780    0.1840    0.8 ];
                    
line_thin = 1;
line_thick = 2;
marker_size = 4;
scale_y = 1.5;
offset_x = 0.025;
offset_y = 0.01;
marker_size = 5;

%% Plot setup
subplot_row = 2;
subplot_col = 2;
subplot_entries = subplot_row*subplot_col;

% Legend
legend1 = legend('hide');
set(legend1,...
     'Position',[0.760680992230167 0.751042709291727 0.118343198475919 0.125105584825402],...
     'Box','off');
hold on


%% Plot 1 (Modulated output)
ax1 = subplot(subplot_row,subplot_col,[1]);
hold on;

p1 = plot(t,modulated_signal,...
    'Color',trans_blue,... 
    'DisplayName','u(t)',...
 	'LineStyle','-',...
	'LineWidth',line_thin);
hold on

p1_a = plot(t,envelope1,...
    'Color',nice_red,... 
    'DisplayName','Upper envelope',...
	'LineStyle','--',...
	'LineWidth',line_thin);
hold on

p1_b = plot(t,envelope2,...
    'Color',pastel_green,... 
    'DisplayName','Lower envelope',...
	'LineStyle','--',...
	'LineWidth',line_thin);
hold on

% Title and Annotations
t1 = title({strcat("Modulated Signal ", p1.DisplayName); " "});

% Axes and labels
ylabel(strcat(p1.DisplayName,' \rightarrow'),...
    'FontName',fontName,...
    'FontSize',14);
xlabel({'t \rightarrow','[seconds]'},...
    'FontName',fontName,...
    'FontSize',14);

y_lim_1 = [floor(min(modulated_signal)) ceil(max(modulated_signal))]*scale_y;
x_lim_1 = [0 t(end)]*1.05;
set(ax1,...
    'FontSize',12,...
    'Box','off',...
    'XAxisLocation','origin',...
    'YMinorTick','off',...
    'XMinorTick','off',...
    'TickDir','both',...
    'TickLabelInterpreter','tex',...
    'YLim',y_lim_1,...
    'XLim',x_lim_1,...
    'XTick',[0: t(end)/8 :t(end)]);
ax1.XAxis.SecondaryLabel.Units='normalized';
ax1.XAxis.SecondaryLabel.Position = [0.972 0.35 0];
ax1.Position = FillAxesPos(ax1,1.1);


%% Plot 2 (Demodulated output)
ax2 = subplot(subplot_row,subplot_col,[2]);
hold on;

p2 = plot(t,demodulated_signal,...
    'Color',nice_red,... 
    'DisplayName','u(t)',...
 	'LineStyle','-',...
	'LineWidth',line_thick);
hold on

% Title and Annotations
t2 = title({strcat("Demodulated Signal ", p2.DisplayName); " "});

% Axes and labels
ylabel(strcat(p2.DisplayName,' \rightarrow'),...
    'FontName',fontName,...
    'FontSize',14);
xlabel({'t \rightarrow','[seconds]'},...
    'FontName',fontName,...
    'FontSize',14);

y_lim_2 = [floor(min(demodulated_signal)) ceil(max(demodulated_signal))]*scale_y;
x_lim_2 = [0 t(end)]*1.05;
set(ax2,...
    'FontSize',12,...
    'Box','off',...
    'XAxisLocation','origin',...
    'YMinorTick','off',...
    'XMinorTick','off',...
    'TickDir','both',...
    'TickLabelInterpreter','tex',...
    'YLim',y_lim_2,...
    'XLim',x_lim_2,...
    'XTick',[0: t(end)/8 :t(end)]);
ax2.XAxis.SecondaryLabel.Units='normalized';
ax2.XAxis.SecondaryLabel.Position = [0.972 0.35 0];
ax2.Position = FillAxesPos(ax2,1.1);

%% Plot 2 (Modulated signal frequency spectrum)
ax3 = subplot(subplot_row,subplot_col,[3]);
hold on;

p3 = stem(f,modulated_frequency,'o',...
    'Color',pastel_blue,... 
    'DisplayName','|M(f)|',...
	'LineStyle','-',...
	'LineWidth',line_thick,...
    'MarkerSize',marker_size,...
    'MarkerFaceColor',pastel_blue(1:3));
hold on

% Title and Annotations
t3 = title({strcat("Modulated signal frequency ", p3.DisplayName); " "});

% Axes and labels
ylabel(p3.DisplayName,...
    'FontName',fontName,...
    'FontSize',14);
xlabel({'f \rightarrow','[Hz]'},...
    'FontName',fontName,...
    'FontSize',14);

y_lim_3 = [0 max(modulated_frequency)]*scale_y;
x_lim_3 = [-f_c f_c]/3;
set(ax3,...
    'Box','off',...
    'XAxisLocation','origin',...
    'YMinorTick','off',...
    'XMinorTick','off',...
    'TickDir','both',...
    'TickLabelInterpreter','tex',...
    'FontSize',12,...
    'YAxisLocation','origin',...
    'XLim',x_lim_3,...
    'XTick',[-f_c-f_m -f_c+f_m -f_m 0 f_m f_c-f_m f_c+f_m],...
    'YTick',[]);

ax3.XAxis.Label.Units='normalized';
ax3.XAxis.Label.Position = [0.98 0.25 0];
ax3.XAxis.SecondaryLabel.Units='normalized';
ax3.XAxis.SecondaryLabel.Position = [0.999 -0.029 0];

ax3.Position = FillAxesPos(ax3,1.1);

%% Plot 4 (Demodulated signal frequency spectrum)
ax4 = subplot(subplot_row,subplot_col,[4]);
hold on;

p4 = stem(f,demodulated_frequency,'o',...
    'Color',nice_red,... 
    'DisplayName','|U(f)|',...
	'LineStyle','-',...
	'LineWidth',line_thick,...
    'MarkerSize',marker_size,...
    'MarkerFaceColor',nice_red(1:3));
hold on

% Title and Annotations
t4 = title({strcat("Demodulated signal frequency ", p4.DisplayName); " "});

% Axes and labels
ylabel(p4.DisplayName,...
    'FontName',fontName,...
    'FontSize',14);
xlabel({'f \rightarrow','[Hz]'},...
    'FontName',fontName,...
    'FontSize',14);

y_lim_4 = [0 max(demodulated_frequency)]*1.2;
x_lim_4 = [floor(-f_m) floor(f_m)]*1.2;
set(ax4,...
    'Box','off',...
    'XAxisLocation','origin',...
    'YMinorTick','off',...
    'XMinorTick','off',...
    'TickDir','both',...
    'TickLabelInterpreter','tex',...
    'FontSize',12,...
    'YAxisLocation','origin',...
    'XLim',x_lim_4,...
    'XTick',[-f_m 0 f_m],...
    'YTick',[]);
ax4.XAxis.Label.Units='normalized';
ax4.XAxis.Label.Position = [0.98 0.25 0];
ax4.XAxis.SecondaryLabel.Units='normalized';
ax4.XAxis.SecondaryLabel.Position = [0.999 -0.029 0];

ax4.Position = FillAxesPos(ax4,1.1);
hold off

set(fig1,'visible','on');
drawnow;