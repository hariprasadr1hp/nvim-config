import pynvim
from util import get_ex_cmd_str
from errors import PluginError


@pynvim.plugin
class PyPlugin:
    def __init__(self, nvim: pynvim.Nvim):
        self.nvim = nvim

    @pynvim.function("ExCommand", sync=True)
    def ex_command_str(self, args: list[str]) -> str:
        if not args:
            raise pynvim.NvimError("Error: need to pass `ex_str` as arg!")
        try:
            return get_ex_cmd_str(args[0])
        except PluginError as e:
            raise pynvim.NvimError from e
