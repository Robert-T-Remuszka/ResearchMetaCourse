'''
This code borrowed from Quant Econ lecure on OOP in Python
https://python-programming.quantecon.org/python_oop.html
'''
class Solow:
    '''
    Methods to implement the simple solow model without population or
    technology growth. The law of motion for the capital-labor ratio is
    then
    k_+ = sAk^alpha + (1-delta)k
    '''
    def __init__(self, 
                 n = 0,       # Population growth rate
                 s = 0.25,    # The (exogenous) saving rate
                 δ = 0.1,     # The depreciation rate
                 α = 0.3,     # Capital share in output (Cobb Douglas)
                 A = 1.0,     # Productivity
                 k = 1.0):    # Current Capital Stock
        
        self.n, self.s, self.δ, self.α, self.A, self.k = n, s, δ, α, A, k

    def h(self, k):
        "The function that updates the state"
        n, s, δ, α, A = self.n, self.s, self.δ, self.α, self.A # Unpacking things
        return (s * A * k**α + (1-δ) * k)/(1+n)
    
    def update(self):
        "Update the state."
        self.k = self.h()

    def steady_state(self):
        "Calculates the steady state."
        n, s, δ, α, A = self.n, self.s, self.δ, self.α, self.A
        return ((A*s)/(δ + n))**(1/(1-α))
    
    def OneStep(self, kgrid):
        "Generates a time series of length t"
        kplus = []
        for k in kgrid:
            kplus.append(self.h(k))
        
        return kplus
        

        