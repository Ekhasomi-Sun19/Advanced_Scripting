class Circle{
    static $Pi = 3.1415927
    [double] $Diameter
    $Color
    Circle([double]$Diameter){
        # initialize the $Diameter property in this constructor
        $this.Diameter = $Diameter

    }
    Circle([double]$Diameter,[string]$hue){
        #initialize TWO properties!!
        $this.Diameter = $Diameter
        $this.Color = $Hue

    }

    static [double]Area([double]$Diameter){
        return [Circle]::Pi * [math]::pow($Diameter/2,2)
    }
    [double]Area(){
        return [Circle]::Area($this.Diameter)
    }
    static [double]Circumference([double]$Diameter){
        return [Circle]::Pi * $Diameter
    }
    [double]Circumference(){
        return [Circle]::Pi * $this.Diameter
    }
}

Class Column:Circle {
    [double]$Height
    static [double]Volume([double]$Diameter,[double]$Height){
        return [Circle]::Area($Diameter) * $Height
    }
    [double]Volume(){
        return [Circle]::Pi * ($this.Diameter/2) * ($this.Diameter/2) * $this.Height
    }
}