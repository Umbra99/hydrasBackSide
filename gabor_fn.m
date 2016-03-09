function gabor_fn(sigma,thetas,lambda,psi,gamma,sizes)

sigma_x = sigma;
sigma_y = sigma/gamma;
fc=1;
for theta = thetas

  % Bounding box
  nstds = 3;
  xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
  xmax = ceil(max(1,xmax));
  ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
  ymax = ceil(max(1,ymax));
  xmin = -xmax; ymin = -ymax;
  [x,y] = meshgrid(xmin:xmax,ymin:ymax);

  % Rotation 
  x_theta=x*cos(theta)+y*sin(theta);
  y_theta=-x*sin(theta)+y*cos(theta);

  gb= exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);

  %disp(size(gb));
  %figure(1);
  %imagesc(gb(22:77,28:75));

  maxi=max(sizes);
  f = zeros(maxi,maxi,size(sizes,2));
  counter = 1;
  for s = sizes
    gb = gb - mean(gb(:));
    min_ = min(gb(:));
    gb = gb - min_;
    max_ = max(gb(:));
    gb = gb / max_;
    image = imresize(gb,[s,s]);
    image = (image * max_) + min_;
    image = padarray(image,[(maxi-s)/2, (maxi-s)/2]);
    f(:,:,counter) = image;
    counter = counter+1;
    
  end
  filters(:,:,:,fc) = f;
  fc = fc+1; 
end

for y=1:size(thetas,2)
    figure(y);
    for x=1:size(sizes,2)

      subplot(3,3,x);
      imagesc(filters(:,:,x,y));
  end
end
filters2=permute(filters,[3,4,1,2]);
save('GaborFilter2.mat', 'filters2', '-v7');