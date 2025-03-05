  { pkgs, ... }:
  {
  programs.wofi = {
    enable = true;
    settings = {
      location = "bottom-right";
      allow_markup = true;
      width = 250;    
    };
    style = ''
      window {
        margin: 0px;
        background-color: #191724;
        border-radius: 0px;
        border: 2px solid #eb6f92;
        color: #e0def4;
        font-family: 'Monofur Nerd Font';
        font-size: 20px;
      }

      #input {
        margin: 5px;
        border-radius: 0px;
        border: none;
        border-radius: 0px;;
        color: #eb6f92;
        background-color: #26233a;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #26233a;
        color: #191724;
        border-radius: 0px;
      }

      #outer-box {
        margin: 15px;
        border: none;
        background-color: #191724;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #e0def4;
      } 

      #entry:selected {
        background-color: #eb6f92;
        color: #191724;
        border-radius: 0px;;
        outline: none;
      }

      #entry:selected * {
        background-color: #eb6f92;
        color: #191724;
        border-radius: 0px;;
        outline: none;
      }
'';
};
}
