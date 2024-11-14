from HiggsAnalysis.CombinedLimit.PhysicsModel import *

 
### This is the base python class to study the Higgs width
 
class Higgswidth(PhysicsModel):
    def __init__(self):
        self.mHRange = []
        self.GGsmfixed = False
        self.is2l2nu = False
        self.poiMap = []
        self.pois = {}
        self.verbose = False
        self.xsec= 1.0 
        self.xsec_vbf= 1.0 
        self.m= 200. 
        self.w= 10. 
    def setModelBuilder(self, modelBuilder):
        PhysicsModel.setModelBuilder(self,modelBuilder)
        self.modelBuilder.doModelBOnly = False
 
    def getYieldScale(self,bin,process):
        #print(process)
        if "ggh" in process: return "ggH_si_func"
        elif "ggH" in process: return "ggH_s_func"
        elif "qqH" in process: return "qqH_s_func"
        elif "vh" in process: return "vh_s_func"
        else:
            return 1
           
    def setPhysicsOptions(self,physOptions):
        pass
           
    def setXsec(self):
        pass

    def doParametersOfInterest(self):
        """Create POI and other parameters, and define the POI set."""

        '''
        self.modelBuilder.doVar("gamma[1,0,50]")

        self.modelBuilder.factory_( "expr::ggH_s_func(\"(1 - sqrt(@0))\", gamma)")
        self.modelBuilder.factory_(  "expr::ggH_si_func(\"sqrt(@0)\", gamma)")

        self.modelBuilder.factory_( "expr::qqH_s_func(\"1\", gamma)")
        self.modelBuilder.factory_( "expr::vh_s_func(\"1\", gamma)")

        self.modelBuilder.doSet("POI","gamma")
        '''

        self.modelBuilder.doVar("gamma[1,0,50]")
        self.modelBuilder.doVar("mu[1,0.5,1.5]")

        self.modelBuilder.factory_( "expr::ggH_s_func(\"(@1 - sqrt(@0*@1))\", gamma, mu)")
        self.modelBuilder.factory_(  "expr::ggH_si_func(\"sqrt(@0*@1)\", gamma, mu)")

        self.modelBuilder.factory_( "expr::qqH_s_func(\"@0\", mu)")
        self.modelBuilder.factory_( "expr::vh_s_func(\"@0\", mu)")

        self.modelBuilder.doSet("POI","gamma,mu")


higgswidth = Higgswidth()
