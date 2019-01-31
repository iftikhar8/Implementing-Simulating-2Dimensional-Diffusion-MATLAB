    L = 1;              %Length of Plate
    H = 1.5;            %Height of Plate
    k = 3.5;            %Diffusivity Constant
    n = 20;             %Number of Nodes (Square Matrix)
    S = 50;             %Source Term
    TS = 10;            %Southern Boundary Temperature
    TN = 30;            %Northern Boundary Temperature
    TW = 60;            %Western Boundary Temperature
    error = 0.1;        %Error Threshold
    T = zeros(n,n);     %Initializing Temperature Values
    QH = zeros(n,n);    %Horizontal Flux Component
    QV = zeros(n,n);    %Vertical Flux Component
%Dimensions
    dx = (L / n);           %Horizontal Steps
    dy = (H / n);           %Vertical Steps
    dz = 1;                 %Thickness
    dV = dy * dx * dz;      %Control Volume for each Node
    X = dx/2:dx:L-(dx/2);   %X Axis Array
    Y = dy/2:dy:H-(dy/2);   %Y Axis Array
%The Main Loop
    e = 1;                  %Error Place Holder
    Iter = 1;
    Iterations = ones(Iter);%Iteration is assigned as a matrix for it to be used in the Residual vs Iterations Graph
    Residuals = ones(Iter); %Residual Matrix
    while e > error
        Told = T;
                    ae = k*dy*dz/dx; 
                    aw = k*dy*dz/dx;
                    as = k*dx*dz/dy;
                    an = k*dx*dz/dy;
                    

                    %Below is the Main Loop, Here is where the values of the temperatures are
                    %updated, notice the 9 if statements corresponding to the sections
                    %configurations descibed in the paper delivered with this code.
                    %If you come across a coefficient ae or an for example
                    %that is multiplied by 2, then that multiplication is
                    %for the reason that that node is in the perimeter of the boundary and
                    %thus its length from its boundary is (dx/2), and this
                    %value is in the denominator which means we'll simply
                    %multiply by 2.

                    
            for i = 1: n
                for j = 1: n
                    %Boundary Conditions  
                    if(i == 1 && j == 1)                    %North West Square
                        ap = ae + aw*2 + as + an*2;
                        T(i,j) = ( T(i+1,j)*as + TN*an*2 + T(i,j+1)*ae + TW*aw*2 + S*dV) / ap;
                        QH(i,j) = k *( (TW-T(i,j+1)) / dx );
                        QV(i,j) = k *( (T(i+1,j)-TN) / dy );

                    elseif(j == 1 && i < n && i > 1)        %Western Boundary
                        ap = ae + aw*2 + as + an;
                        T(i,j) = ( T(i+1,j)*as + T(i-1,j)*an + T(i,j+1)*ae + TW*aw*2 + S*dV) / ap;
                        QH(i,j) = k *( (TW-T(i,j+1)) / dx );
                        QV(i,j) = k *( (T(i+1,j)-T(i-1,j)) / dy );

                    elseif(i == n && j == 1)                %South West Square
                        ap = ae + aw*2 + as*2 + an;
                        T(i,j) = ( TS*as*2 + T(i-1,j)*an + T(i,j+1)*ae + TW*aw*2 + S*dV) / ap;
                        QH(i,j) = k *( (TW-T(i,j+1)) / dx );
                        QV(i,j) = k *( (TS-T(i-1,j)) / dy );

                    elseif(i == n && j < n && j > 1)        %Southern Boundary
                        ap = ae + aw + as*2 + an;
                        T(i,j) = ( TS*as*2 + T(i-1,j)*an + T(i,j+1)*ae + T(i,j-1)*aw + S*dV) / ap;
                        QH(i,j) = k *( (T(i,j-1)-T(i,j+1)) / dx );
                        QV(i,j) = k *( (TS-T(i-1,j)) / dy );

                    elseif(i == n && j == n)                %South East Square
                        ap = aw + as*2 + an;
                        T(i,j) = ( TS*as*2 + T(i-1,j)*an + T(i,j-1)*aw + S*dV) / ap;
                        QH(i,j) = k *( (T(i,j-1)) / dx );
                        QV(i,j) = k *( (TS-T(i-1,j)) / dy );

                    elseif(j == n && i < n && i > 1)        %Eastern Boundary
                        ap = aw + as + an;
                        T(i,j) = ( T(i+1,j)*as + T(i-1,j)*an + T(i,j-1)*aw + S*dV) / ap;
                        QH(i,j) = k *( (T(i,j-1)) / dx );
                        QV(i,j) = k *( (T(i+1,j)-T(i-1,j)) / dy );

                    elseif(i == 1 && j == n)                %North East Square
                        ap = aw + as + an*2;
                        T(i,j) = ( T(i+1,j)*as + TN*an*2 + T(i,j-1)*aw + S*dV) / ap;
                        QH(i,j) = k *( (T(i,j-1)) / dx );
                        QV(i,j) = k *( (T(i+1,j)-TN) / dy );

                    elseif(i == 1 && j < n && j > 1)        %Northern Boundary
                        ap = ae + aw + as + an*2;
                        T(i,j) = ( T(i+1,j)*as + TN*an*2 + T(i,j+1)*ae + T(i,j-1)*aw + S*dV) / ap;
                        QH(i,j) = k *( (T(i,j-1)-T(i,j+1)) / dx );
                        QV(i,j) = k *( (T(i+1,j)-TN) / dy );

                    elseif(j > 1 && j < n && i > 1 && i < n) %Middle Portion
                        ap = ae + aw + as + an;
                        T(i,j) = ( T(i+1,j)*as + T(i-1,j)*an + T(i,j+1)*ae + T(i,j-1)*aw + S*dV) / ap;
                        QH(i,j) = k *( (T(i,j-1)-T(i,j+1)) / dx );
                        QV(i,j) = k *( (T(i+1,j)-T(i-1,j)) / dy );
                    end
                end
            end
            
    %Normalized Residual at each Node & Flux          

        e = 1;                                  %Error Reassigning
        R = sum(sum(abs(T-Told)))               %Residual
        FV = sum(sum(QV));                      %Vertical Flux
        FH = sum(sum(QH));                      %Horizontal Flux
        AFV = FV/(n^2);                         %Average Vertical Flux (We divided by n^2 to calculate the average flux for all the nodes, which are n^2 node)
        AFH = FH/(n^2);                         %Average Horizontal Flux
        F = QV + QH;                            %Total Flux
        e = sum(sum(abs((abs(T-Told)./F))));    %Normalized Error
    %Residual vs Iterations Calculations
        Residuals(Iter) = R;
        Iterations(Iter) = Iter;
        Iter = Iter + 1;
    %The Surface Graphics Code
        [yy,xx] = meshgrid(X,Y);
        zz = T;
        axis([0 H 0 L 0 100]);
        surf(xx,yy,zz)
        pause(0.0001)
        colormap('jet')
    end
Iterations(Iter-1)
%plot(Residuals,Iterations)    %uncomment this line to get the Residual vs Iterations graph