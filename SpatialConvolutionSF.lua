local SpatialConvolutionSF, Parent = torch.class('nn.SpatialConvolutionSF', 'nn.SpatialConvolution')
 
function SpatialConvolutionSF:__init(index, nInputPlane, nOutputPlane, kW, kH, dW, dH, padW, padH)
   parent.__init(self, nInputPlane, nOutputPlane, kW, kH, dW, dH, padW, padH)
	self.index = index
end
 

function SpatialConvolutionSF:reset(stdv)
   self.bias:fill(0)
   matio = require 'matio'

   testmatrix= matio.load('GaborFilter2.mat','filter2')
   self.weight= testmatrix[{},{self.index},{},{}]

end

local function makeContiguous(self, input, gradOutput)
   if not input:isContiguous() then
      self._input = self._input or input.new()
      self._input:resizeAs(input):copy(input)
      input = self._input
   end
   if gradOutput then
      if not gradOutput:isContiguous() then
	 self._gradOutput = self._gradOutput or gradOutput.new()
	 self._gradOutput:resizeAs(gradOutput):copy(gradOutput)
	 gradOutput = self._gradOutput
      end
   end
   return input, gradOutput
end
