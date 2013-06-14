#!/usr/bin/env python
import pprint
import jinja2
import yaml


class FuelTemplates:

    def __init__(self):
        self.pp = pprint.PrettyPrinter(indent=2)
        self.dump = self.pp.pprint
        self.template_loader = jinja2.FileSystemLoader(searchpath="templates/simple_demo")
        self.template_environment = templateEnv = jinja2.Environment(
            loader=self.template_loader,
        )
        self.data = {}

    def selectTemplate(self, template_dir):
        pass

    def parseConfigYaml(self, config_yaml):
        stream = open(config_yaml, 'r')
        self.data = yaml.load(stream)

    def dumpData(self):
        print (self.dump(self.data))

    def makeManifest(self, template_file):
        template = self.template_environment.get_template(template_file)
        compiled_template = template.render(self.data)
        return compiled_template

FT = FuelTemplates()
FT.parseConfigYaml('data/config.yaml')
print "file: site.pp"
print FT.makeManifest('site.pp')
print
print "file: description.txt"
print FT.makeManifest('description.txt').encode('utf8')
print
print "file: nagios.cfg"
print FT.makeManifest('nagios.cfg')