input = 'test-images/doorknob.jpeg';
output = [input '_out.jpeg'];
[R]=ImageRetarget(0,0,input,167,318);
%[R]=ImageRetarget(0,0,input,247,465);
imshow(R);
imwrite(R,output,'jpeg');