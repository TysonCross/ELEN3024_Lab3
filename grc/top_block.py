#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Top Block
# Generated: Fri Aug 24 04:53:11 2018
##################################################

if __name__ == '__main__':
    import ctypes
    import sys
    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print "Warning: failed to XInitThreads()"

from PyQt4 import Qt
from PyQt4.QtCore import QObject, pyqtSlot
from gnuradio import analog
from gnuradio import audio
from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import filter
from gnuradio import gr
from gnuradio import qtgui
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from gnuradio.qtgui import Range, RangeWidget
from optparse import OptionParser
import sip
import sys


class top_block(gr.top_block, Qt.QWidget):

    def __init__(self):
        gr.top_block.__init__(self, "Top Block")
        Qt.QWidget.__init__(self)
        self.setWindowTitle("Top Block")
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except:
            pass
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.restoreGeometry(self.settings.value("geometry").toByteArray())

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 44000
        self.resamp_factor = resamp_factor = 1
        self.gain = gain = 1.1
        self.filter_width = filter_width = 600
        self.filter_type = filter_type = 3
        self.filter_frequency = filter_frequency = 6e3
        self.dc_block_length = dc_block_length = 32
        self.carrier_frequency = carrier_frequency = 2e6

        ##################################################
        # Blocks
        ##################################################
        self._gain_range = Range(0, 10, .1, 1.1, 200)
        self._gain_win = RangeWidget(self._gain_range, self.set_gain, 'Gain', "counter_slider", float)
        self.top_grid_layout.addWidget(self._gain_win, 1,4,1,1)
        self._filter_width_range = Range(10, 1000, 1, 600, 200)
        self._filter_width_win = RangeWidget(self._filter_width_range, self.set_filter_width, 'Filter Width', "counter_slider", float)
        self.top_grid_layout.addWidget(self._filter_width_win, 1, 3, 1, 1)
        self._filter_type_options = (0, 1, 2, 3, 4, )
        self._filter_type_labels = ('Hamming', 'Hann', 'Blackman', 'Rectangular', 'Kaiser', )
        self._filter_type_tool_bar = Qt.QToolBar(self)
        self._filter_type_tool_bar.addWidget(Qt.QLabel('Filter type'+": "))
        self._filter_type_combo_box = Qt.QComboBox()
        self._filter_type_tool_bar.addWidget(self._filter_type_combo_box)
        for label in self._filter_type_labels: self._filter_type_combo_box.addItem(label)
        self._filter_type_callback = lambda i: Qt.QMetaObject.invokeMethod(self._filter_type_combo_box, "setCurrentIndex", Qt.Q_ARG("int", self._filter_type_options.index(i)))
        self._filter_type_callback(self.filter_type)
        self._filter_type_combo_box.currentIndexChanged.connect(
        	lambda i: self.set_filter_type(self._filter_type_options[i]))
        self.top_grid_layout.addWidget(self._filter_type_tool_bar, 1,1,1,1)
        self._filter_frequency_range = Range(1e2, 1e5, 100, 6e3, 200)
        self._filter_frequency_win = RangeWidget(self._filter_frequency_range, self.set_filter_frequency, 'Cutoff Frequency', "counter_slider", float)
        self.top_grid_layout.addWidget(self._filter_frequency_win, 1, 2, 1, 1)
        self._dc_block_length_range = Range(0, 1000, 2, 32, 200)
        self._dc_block_length_win = RangeWidget(self._dc_block_length_range, self.set_dc_block_length, 'DC Block length', "counter_slider", int)
        self.top_grid_layout.addWidget(self._dc_block_length_win, 1, 5, 1, 1)
        self.qtgui_time_sink_x_0_0 = qtgui.time_sink_f(
        	1024*2, #size
        	samp_rate, #samp_rate
        	"Reconstructed Signal", #name
        	1 #number of inputs
        )
        self.qtgui_time_sink_x_0_0.set_update_time(0.1)
        self.qtgui_time_sink_x_0_0.set_y_axis(-1, 1)
        
        self.qtgui_time_sink_x_0_0.set_y_label('Amplitude', "")
        
        self.qtgui_time_sink_x_0_0.enable_tags(-1, True)
        self.qtgui_time_sink_x_0_0.set_trigger_mode(qtgui.TRIG_MODE_FREE, qtgui.TRIG_SLOPE_POS, 100, 0, 0, "")
        self.qtgui_time_sink_x_0_0.enable_autoscale(True)
        self.qtgui_time_sink_x_0_0.enable_grid(False)
        self.qtgui_time_sink_x_0_0.enable_axis_labels(True)
        self.qtgui_time_sink_x_0_0.enable_control_panel(False)
        
        if not False:
          self.qtgui_time_sink_x_0_0.disable_legend()
        
        labels = ['', '', '', '', '',
                  '', '', '', '', '']
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "blue"]
        styles = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        markers = [-1, -1, -1, -1, -1,
                   -1, -1, -1, -1, -1]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]
        
        for i in xrange(1):
            if len(labels[i]) == 0:
                self.qtgui_time_sink_x_0_0.set_line_label(i, "Data {0}".format(i))
            else:
                self.qtgui_time_sink_x_0_0.set_line_label(i, labels[i])
            self.qtgui_time_sink_x_0_0.set_line_width(i, widths[i])
            self.qtgui_time_sink_x_0_0.set_line_color(i, colors[i])
            self.qtgui_time_sink_x_0_0.set_line_style(i, styles[i])
            self.qtgui_time_sink_x_0_0.set_line_marker(i, markers[i])
            self.qtgui_time_sink_x_0_0.set_line_alpha(i, alphas[i])
        
        self._qtgui_time_sink_x_0_0_win = sip.wrapinstance(self.qtgui_time_sink_x_0_0.pyqwidget(), Qt.QWidget)
        self.top_grid_layout.addWidget(self._qtgui_time_sink_x_0_0_win, 2,1,2,5)
        self.qtgui_freq_sink_x_0_0_0_0 = qtgui.freq_sink_f(
        	1024*10, #size
        	firdes.WIN_HAMMING, #wintype
        	0, #fc
        	samp_rate/2, #bw
        	"Original Signal Frequency", #name
        	1 #number of inputs
        )
        self.qtgui_freq_sink_x_0_0_0_0.set_update_time(1)
        self.qtgui_freq_sink_x_0_0_0_0.set_y_axis(-140, 10)
        self.qtgui_freq_sink_x_0_0_0_0.set_y_label('Relative Gain', 'dB')
        self.qtgui_freq_sink_x_0_0_0_0.set_trigger_mode(qtgui.TRIG_MODE_AUTO, 0.0, 0, "")
        self.qtgui_freq_sink_x_0_0_0_0.enable_autoscale(True)
        self.qtgui_freq_sink_x_0_0_0_0.enable_grid(False)
        self.qtgui_freq_sink_x_0_0_0_0.set_fft_average(1.0)
        self.qtgui_freq_sink_x_0_0_0_0.enable_axis_labels(True)
        self.qtgui_freq_sink_x_0_0_0_0.enable_control_panel(False)
        
        if not False:
          self.qtgui_freq_sink_x_0_0_0_0.disable_legend()
        
        if "float" == "float" or "float" == "msg_float":
          self.qtgui_freq_sink_x_0_0_0_0.set_plot_pos_half(not True)
        
        labels = ['', '', '', '', '',
                  '', '', '', '', '']
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "dark blue"]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]
        for i in xrange(1):
            if len(labels[i]) == 0:
                self.qtgui_freq_sink_x_0_0_0_0.set_line_label(i, "Data {0}".format(i))
            else:
                self.qtgui_freq_sink_x_0_0_0_0.set_line_label(i, labels[i])
            self.qtgui_freq_sink_x_0_0_0_0.set_line_width(i, widths[i])
            self.qtgui_freq_sink_x_0_0_0_0.set_line_color(i, colors[i])
            self.qtgui_freq_sink_x_0_0_0_0.set_line_alpha(i, alphas[i])
        
        self._qtgui_freq_sink_x_0_0_0_0_win = sip.wrapinstance(self.qtgui_freq_sink_x_0_0_0_0.pyqwidget(), Qt.QWidget)
        self.top_layout.addWidget(self._qtgui_freq_sink_x_0_0_0_0_win)
        self.qtgui_freq_sink_x_0_0_0 = qtgui.freq_sink_f(
        	1024*10, #size
        	firdes.WIN_HAMMING, #wintype
        	0, #fc
        	samp_rate/2, #bw
        	"Reconstructed Signal Frequency", #name
        	1 #number of inputs
        )
        self.qtgui_freq_sink_x_0_0_0.set_update_time(1)
        self.qtgui_freq_sink_x_0_0_0.set_y_axis(-140, 10)
        self.qtgui_freq_sink_x_0_0_0.set_y_label('Relative Gain', 'dB')
        self.qtgui_freq_sink_x_0_0_0.set_trigger_mode(qtgui.TRIG_MODE_AUTO, 0.0, 0, "")
        self.qtgui_freq_sink_x_0_0_0.enable_autoscale(True)
        self.qtgui_freq_sink_x_0_0_0.enable_grid(False)
        self.qtgui_freq_sink_x_0_0_0.set_fft_average(1.0)
        self.qtgui_freq_sink_x_0_0_0.enable_axis_labels(True)
        self.qtgui_freq_sink_x_0_0_0.enable_control_panel(False)
        
        if not False:
          self.qtgui_freq_sink_x_0_0_0.disable_legend()
        
        if "float" == "float" or "float" == "msg_float":
          self.qtgui_freq_sink_x_0_0_0.set_plot_pos_half(not True)
        
        labels = ['', '', '', '', '',
                  '', '', '', '', '']
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "dark blue"]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]
        for i in xrange(1):
            if len(labels[i]) == 0:
                self.qtgui_freq_sink_x_0_0_0.set_line_label(i, "Data {0}".format(i))
            else:
                self.qtgui_freq_sink_x_0_0_0.set_line_label(i, labels[i])
            self.qtgui_freq_sink_x_0_0_0.set_line_width(i, widths[i])
            self.qtgui_freq_sink_x_0_0_0.set_line_color(i, colors[i])
            self.qtgui_freq_sink_x_0_0_0.set_line_alpha(i, alphas[i])
        
        self._qtgui_freq_sink_x_0_0_0_win = sip.wrapinstance(self.qtgui_freq_sink_x_0_0_0.pyqwidget(), Qt.QWidget)
        self.top_grid_layout.addWidget(self._qtgui_freq_sink_x_0_0_0_win, 4,1,2,5)
        self.low_pass_filter_0_0 = filter.fir_filter_fff(1, firdes.low_pass(
        	1, samp_rate, filter_frequency, filter_width, filter_type, 6.76))
        self.dc_blocker_xx_0 = filter.dc_blocker_ff(dc_block_length, True)
        self.blocks_wavfile_source_0 = blocks.wavfile_source('/Users/Tyson/Documents/Academic/ELEN3024/Labs/Lab3/audio/example.wav', True)
        self.blocks_throttle_0 = blocks.throttle(gr.sizeof_float*1, samp_rate,True)
        self.blocks_multiply_xx_0 = blocks.multiply_vcc(1)
        self.blocks_multiply_const_vxx_0_0 = blocks.multiply_const_vff((2, ))
        self.blocks_multiply_const_vxx_0 = blocks.multiply_const_vff((gain, ))
        self.blocks_float_to_complex_0 = blocks.float_to_complex(1)
        self.blocks_complex_to_mag_0 = blocks.complex_to_mag(1)
        self.audio_sink_0 = audio.sink(samp_rate, '', True)
        self.analog_sig_source_x_0 = analog.sig_source_c(samp_rate, analog.GR_COS_WAVE, carrier_frequency, 1, 0)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.analog_sig_source_x_0, 0), (self.blocks_multiply_xx_0, 1))    
        self.connect((self.blocks_complex_to_mag_0, 0), (self.low_pass_filter_0_0, 0))    
        self.connect((self.blocks_float_to_complex_0, 0), (self.blocks_multiply_xx_0, 0))    
        self.connect((self.blocks_multiply_const_vxx_0, 0), (self.dc_blocker_xx_0, 0))    
        self.connect((self.blocks_multiply_const_vxx_0_0, 0), (self.blocks_multiply_const_vxx_0, 0))    
        self.connect((self.blocks_multiply_xx_0, 0), (self.blocks_complex_to_mag_0, 0))    
        self.connect((self.blocks_throttle_0, 0), (self.blocks_float_to_complex_0, 0))    
        self.connect((self.blocks_wavfile_source_0, 0), (self.blocks_throttle_0, 0))    
        self.connect((self.blocks_wavfile_source_0, 0), (self.qtgui_freq_sink_x_0_0_0_0, 0))    
        self.connect((self.dc_blocker_xx_0, 0), (self.audio_sink_0, 0))    
        self.connect((self.dc_blocker_xx_0, 0), (self.qtgui_freq_sink_x_0_0_0, 0))    
        self.connect((self.dc_blocker_xx_0, 0), (self.qtgui_time_sink_x_0_0, 0))    
        self.connect((self.low_pass_filter_0_0, 0), (self.blocks_multiply_const_vxx_0_0, 0))    

    def closeEvent(self, event):
        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.settings.setValue("geometry", self.saveGeometry())
        event.accept()

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.qtgui_time_sink_x_0_0.set_samp_rate(self.samp_rate)
        self.qtgui_freq_sink_x_0_0_0_0.set_frequency_range(0, self.samp_rate/2)
        self.qtgui_freq_sink_x_0_0_0.set_frequency_range(0, self.samp_rate/2)
        self.low_pass_filter_0_0.set_taps(firdes.low_pass(1, self.samp_rate, self.filter_frequency, self.filter_width, self.filter_type, 6.76))
        self.blocks_throttle_0.set_sample_rate(self.samp_rate)
        self.analog_sig_source_x_0.set_sampling_freq(self.samp_rate)

    def get_resamp_factor(self):
        return self.resamp_factor

    def set_resamp_factor(self, resamp_factor):
        self.resamp_factor = resamp_factor

    def get_gain(self):
        return self.gain

    def set_gain(self, gain):
        self.gain = gain
        self.blocks_multiply_const_vxx_0.set_k((self.gain, ))

    def get_filter_width(self):
        return self.filter_width

    def set_filter_width(self, filter_width):
        self.filter_width = filter_width
        self.low_pass_filter_0_0.set_taps(firdes.low_pass(1, self.samp_rate, self.filter_frequency, self.filter_width, self.filter_type, 6.76))

    def get_filter_type(self):
        return self.filter_type

    def set_filter_type(self, filter_type):
        self.filter_type = filter_type
        self._filter_type_callback(self.filter_type)
        self.low_pass_filter_0_0.set_taps(firdes.low_pass(1, self.samp_rate, self.filter_frequency, self.filter_width, self.filter_type, 6.76))

    def get_filter_frequency(self):
        return self.filter_frequency

    def set_filter_frequency(self, filter_frequency):
        self.filter_frequency = filter_frequency
        self.low_pass_filter_0_0.set_taps(firdes.low_pass(1, self.samp_rate, self.filter_frequency, self.filter_width, self.filter_type, 6.76))

    def get_dc_block_length(self):
        return self.dc_block_length

    def set_dc_block_length(self, dc_block_length):
        self.dc_block_length = dc_block_length

    def get_carrier_frequency(self):
        return self.carrier_frequency

    def set_carrier_frequency(self, carrier_frequency):
        self.carrier_frequency = carrier_frequency
        self.analog_sig_source_x_0.set_frequency(self.carrier_frequency)


def main(top_block_cls=top_block, options=None):

    from distutils.version import StrictVersion
    if StrictVersion(Qt.qVersion()) >= StrictVersion("4.5.0"):
        style = gr.prefs().get_string('qtgui', 'style', 'raster')
        Qt.QApplication.setGraphicsSystem(style)
    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()
    tb.start()
    tb.show()

    def quitting():
        tb.stop()
        tb.wait()
    qapp.connect(qapp, Qt.SIGNAL("aboutToQuit()"), quitting)
    qapp.exec_()


if __name__ == '__main__':
    main()
