// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// converts tokens to AST!
#region gml.builder

if (live_enabled) 
function gml_builder(l_pg, l_src) constructor {
	// gml_builder(pg:gml_program, src:gml_source)
	/// @ignore
	static h_tokens = undefined; /// @is {array<gml_token>}
	static h_source = undefined; /// @is {gml_source}
	static h_offset = undefined; /// @is {int}
	static h_length = undefined; /// @is {int}
	static h_scripts = undefined; /// @is {array<gml_script>}
	static h_enums = undefined; /// @is {array<gml_enum>}
	static h_macro_names = undefined; /// @is {array<string>}
	static h_macro_nodes = undefined; /// @is {array<gml_macro>}
	static h_global_vars = undefined; /// @is {array<string>}
	static h_run = function() {
		if (self.h_error_text == undefined) self.h_build_loop(self.h_source.h_main);
	}
	static h_error_text = undefined; /// @is {string}
	static h_error_pos = undefined; /// @is {gml_pos}
	static h_error_at = function(l_text, l_pos) {
		self.h_error_text = gml_pos_to_string(l_pos, self.h_program) + ": " + l_text;
		self.h_error_pos = l_pos;
		return true;
	}
	static h_error = function(l_text, l_tk) {
		return self.h_error_at(l_text, l_tk[1]);
	}
	static h_expect = function(l_text, l_tk) {
		return self.h_error("Expected " + l_text + ", got " + g_gml_token_constructors[l_tk[0]], l_tk);
	}
	static h_expect_node = function(l_text, l_node) {
		return self.h_error_at("Expected " + l_text + ", got " + g_gml_node_constructors[l_node[0]], gml_std_haxe_enum_tools_getParameter(l_node, 0));
	}
	static h_out_node = undefined; /// @is {ast_GmlNode}
	static h_current_script = undefined; /// @is {string}
	static h_current_script_ref = undefined; /// @is {gml_script}
	static h_build_ops = function(l_firstPos, l_firstOp) {
		self.h_offset += 1;
		var l_nodes = ds_list_create();
		ds_list_add(l_nodes, self.h_out_node);
		var l_ops = ds_list_create();
		ds_list_add(l_ops, l_firstOp);
		var l_locs = ds_list_create();
		ds_list_add(l_locs, l_firstPos);
		var l_proc = true;
		var l_i;
		while (l_proc && self.h_offset < self.h_length) {
			if (self.h_build_expr(1)) {
				ds_list_destroy(l_nodes);
				ds_list_destroy(l_ops);
				ds_list_destroy(l_locs);
				return true;
			}
			ds_list_add(l_nodes, self.h_out_node);
			if (self.h_offset < self.h_length) {
				var l__g = self.h_tokens[self.h_offset];
				switch (l__g[0]) {
					case gml_token.bin_op:
						self.h_offset += 1;
						ds_list_add(l_locs, l__g[1/* d */]);
						ds_list_add(l_ops, l__g[2/* op */]);
						break;
					case gml_token.set_op:
						if (l__g[2/* op */] == -1) {
							self.h_offset += 1;
							ds_list_add(l_locs, l__g[1/* d */]);
							ds_list_add(l_ops, 64);
						} else l_proc = false;
						break;
					default: l_proc = false;
				}
			}
		}
		var l_pmin = 7;
		var l_pmax = 0;
		var l_n = ds_list_size(l_ops);
		for (l_i = 0; l_i < l_n; l_i++) {
			var l_pcur = gml_op_get_priority(ds_list_find_value(l_ops, l_i));
			if (l_pcur < l_pmin) l_pmin = l_pcur;
			if (l_pcur > l_pmax) l_pmax = l_pcur;
		}
		while (l_pmin <= l_pmax) {
			for (l_i = 0; l_i < l_n; l_i++) {
				if (gml_op_get_priority(ds_list_find_value(l_ops, l_i)) == l_pmin) {
					ds_list_set(l_nodes, l_i, [gml_node.bin_op, ds_list_find_value(l_locs, l_i), ds_list_find_value(l_ops, l_i), ds_list_find_value(l_nodes, l_i), ds_list_find_value(l_nodes, l_i + 1)]);
					ds_list_delete(l_nodes, l_i + 1);
					ds_list_delete(l_ops, l_i);
					ds_list_delete(l_locs, l_i);
					l_n--;
					l_i--;
				}
			}
			l_pmin++;
		}
		self.h_out_node = ds_list_find_value(l_nodes, 0);
		ds_list_destroy(l_nodes);
		ds_list_destroy(l_ops);
		ds_list_destroy(l_locs);
		return false;
	}
	static h_build_args = function(l_pos, l_sqb) {
		var l_args1 = [];
		var l_proc = true;
		var l_seenComma = true;
		var l_func = self.h_out_node;
		while (l_proc && self.h_offset < self.h_length) {
			var l_tk = self.h_tokens[self.h_offset];
			switch (l_tk[0]) {
				case gml_token.par_close:
					if (l_sqb) {
						return self.h_error("Unexpected `)`", l_tk);
					} else {
						l_proc = false;
						self.h_offset += 1;
					}
					break;
				case gml_token.sqb_close:
					if (l_sqb) {
						l_proc = false;
						self.h_offset += 1;
					} else return self.h_error("Unexpected `]`", l_tk);
					break;
				case gml_token.comma:
					if (l_seenComma) {
						array_push(l_args1, [gml_node.undefined_hx, l_tk[1/* d */]]);
						self.h_offset += 1;
					} else {
						l_seenComma = true;
						self.h_offset += 1;
					}
					break;
				default:
					if (l_seenComma) {
						l_seenComma = false;
						if (self.h_build_expr(0)) return true;
						array_push(l_args1, self.h_out_node);
					} else return self.h_expect("a comma or closing token.", l_tk);
			}
		}
		if (l_proc) return self.h_error_at("Unclosed list", l_pos);
		if (l_sqb) self.h_out_node = [gml_node.array_decl, l_pos, l_args1]; else self.h_out_node = [gml_node.call, l_pos, l_func, l_args1];
		return false;
	}
	static h_build_expr = function(l_flags) {
		if (self.h_offset >= self.h_length) return self.h_error_at("Expected an expression", self.h_source.h_get_eof());
		var l_proc, l_sep, l_i, l_n, l_s, l_tk;
		var l_tk0 = self.h_tokens[self.h_offset++];
		var l_node, l_node2, l_nodes;
		switch (l_tk0[0]) {
			case gml_token.undefined_hx: self.h_out_node = [gml_node.undefined_hx, l_tk0[1/* d */]]; break;
			case gml_token.number: self.h_out_node = [gml_node.number, l_tk0[1/* d */], l_tk0[2/* nu */], l_tk0[3/* src */]]; break;
			case gml_token.boolean: self.h_out_node = [gml_node.boolean, l_tk0[1/* d */], l_tk0[2/* value */]]; break;
			case gml_token.cstring: self.h_out_node = [gml_node.cstring, l_tk0[1/* d */], l_tk0[2/* st */]]; break;
			case gml_token.sqb_open:
				if (l_tk0[2/* accessorChar */] == 0) {
					l_proc = true;
					l_sep = true;
					self.h_build_args(l_tk0[1/* d */], true);
				} else if ((l_flags & 4) != 0) {
					return self.h_expect("a statement", l_tk0);
				} else return self.h_expect("a value", l_tk0);
				break;
			case gml_token.ident:
				var l_s1 = l_tk0[2/* id */];
				switch (l_s1) {
					case "self": self.h_out_node = [gml_node.self_hx, l_tk0[1/* d */]]; break;
					case "other": self.h_out_node = [gml_node.other_hx, l_tk0[1/* d */]]; break;
					default:
						if (gml_asset_index[$ l_s1] != undefined) {
							l_i = gml_asset_index[$ l_s1];
							self.h_out_node = [gml_node.number, l_tk0[1/* d */], l_i, undefined];
						} else {
							var l_m = self.h_program.h_macro_map[$ l_s1];
							if (l_m != undefined && l_m.h_is_expr) self.h_out_node = gml_node_tools_clone(l_m.h_node); else self.h_out_node = [gml_node.ident, l_tk0[1/* d */], l_s1];
						}
				}
				break;
			case gml_token.arg_const: self.h_out_node = [gml_node.arg_const, l_tk0[1/* d */], l_tk0[2/* i */]]; break;
			case gml_token.un_op:
				if (self.h_build_expr(1)) return true;
				var l__g = self.h_out_node;
				if (l__g[0]/* gml_node */ == gml_node.number) {
					var l_f = l__g[2/* value */];
					switch (l_tk0[2/* op */]) {
						case 2: l_f = ~(l_f | 0); break;
						case 0: l_f = -l_f; break;
						case 1: l_f = (l_f > 0.5 ? 0 : 1); break;
					}
					self.h_out_node = [gml_node.number, l_tk0[1/* d */], l_f, undefined];
				} else self.h_out_node = [gml_node.un_op, l_tk0[1/* d */], self.h_out_node, l_tk0[2/* op */]];
				break;
			case gml_token.adjfix:
				if (self.h_build_expr(1)) return true;
				self.h_out_node = [gml_node.prefix, l_tk0[1/* d */], self.h_out_node, l_tk0[2/* inc */]];
				break;
			case gml_token.bin_op:
				var l__g = l_tk0[1/* d */];
				switch (l_tk0[2/* op */]) {
					case 16: if (self.h_build_expr(1)) return true; break;
					case 17:
						var l_d = l__g;
						if (self.h_build_expr(1)) return true;
						var l__g = self.h_out_node;
						if (l__g[0]/* gml_node */ == gml_node.number) self.h_out_node = [gml_node.number, l_d, -l__g[2/* value */], undefined]; else self.h_out_node = [gml_node.un_op, l_d, self.h_out_node, 0];
						break;
					default: if ((l_flags & 4) != 0) return self.h_expect("a statement", l_tk0); else return self.h_expect("a value", l_tk0);
				}
				break;
			case gml_token.par_open:
				if (self.h_build_expr(0)) return true;
				if (self.h_offset >= self.h_length) return self.h_error("Unclosed parenthesis", l_tk0);
				if (self.h_offset >= self.h_length) {
					return self.h_error_at("Expected a closing parenthesis", self.h_source.h_get_eof());
				} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_close) {
					self.h_offset += 1;
				} else return self.h_error("Expected a closing parenthesis", self.h_tokens[self.h_offset]);
				break;
			case gml_token.cub_open:
				var l_d = l_tk0[1/* d */];
				var l_keys = [];
				l_nodes = [];
				l_proc = true;
				var l__g = self.h_tokens[self.h_offset];
				if ((l__g[0] == 26)) {
					l_proc = false;
					self.h_offset += 1;
				} else while (l_proc && self.h_offset < self.h_length) {
					var l__g = self.h_tokens[self.h_offset];
					switch (l__g[0]) {
						case gml_token.ident:
							l_s = l__g[2/* id */];
							array_push(l_keys, l_s);
							self.h_offset += 1;
							if (self.h_offset >= self.h_length) continue;
							var l__g1 = self.h_tokens[self.h_offset];
							var l_tmp;
							if (l__g1[0]/* gml_token */ == gml_token.colon) l_tmp = true; else l_tmp = false;
							if (l_tmp) {
								self.h_offset += 1;
								if (self.h_build_expr(0)) return true;
								array_push(l_nodes, self.h_out_node);
							} else {
								l_node = [gml_node.ident, l__g[1/* d */], l_s];
								array_push(l_nodes, l_node);
							}
							switch (self.h_tokens[self.h_offset][0]) {
								case gml_token.comma:
									self.h_offset += 1;
									if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.cub_close) {
										self.h_offset += 1;
										l_proc = false;
									}
									break;
								case gml_token.cub_close:
									self.h_offset += 1;
									l_proc = false;
									break;
								default: return self.h_expect("a `,` or a `}` in object declaration", self.h_tokens[self.h_offset]);
							}
							break;
						case gml_token.cstring:
							l_s = l__g[2/* st */];
							array_push(l_keys, l_s);
							self.h_offset += 1;
							if (self.h_offset >= self.h_length) continue;
							var l__g8 = self.h_tokens[self.h_offset];
							var l_tmp1;
							if (l__g8[0]/* gml_token */ == gml_token.colon) l_tmp1 = true; else l_tmp1 = false;
							if (l_tmp1) {
								self.h_offset += 1;
								if (self.h_build_expr(0)) return true;
								array_push(l_nodes, self.h_out_node);
							} else {
								l_node = [gml_node.ident, l__g[1/* d */], l_s];
								array_push(l_nodes, l_node);
							}
							switch (self.h_tokens[self.h_offset][0]) {
								case gml_token.comma:
									self.h_offset += 1;
									if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.cub_close) {
										self.h_offset += 1;
										l_proc = false;
									}
									break;
								case gml_token.cub_close:
									self.h_offset += 1;
									l_proc = false;
									break;
								default: return self.h_expect("a `,` or a `}` in object declaration", self.h_tokens[self.h_offset]);
							}
							break;
						default: return self.h_expect("a key-value pair or a `}` in object declaration", self.h_tokens[self.h_offset]);
					}
				}
				if (l_proc) return self.h_error_at("Unclosed struct literal", l_d);
				self.h_out_node = [gml_node.object_decl, l_d, l_keys, l_nodes];
				break;
			case gml_token.header: if ((l_flags & 4) != 0) return self.h_error("Expected a statement, got a header (did you miss a closing bracket?)", l_tk0); else return self.h_error("Expected an expression, got a header (did you miss a closing parenthesis?)", l_tk0);
			case gml_token.keyword:
				switch (l_tk0[2/* kw */]) {
					case 0:
						var l_d = l_tk0[1/* d */];
						if (self.h_offset >= self.h_length) {
							self.h_out_node = [gml_node.global_ref, l_d];
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.period) {
							l_tk = self.h_tokens[self.h_offset++];
							if (self.h_offset >= self.h_length) {
								return self.h_expect("a field name", l_tk);
							} else {
								var l__g1 = self.h_tokens[self.h_offset];
								if (l__g1[0]/* gml_token */ == gml_token.ident) {
									self.h_offset += 1;
									self.h_out_node = [gml_node.global_hx, l__g1[1/* d */], l__g1[2/* id */]];
								} else return self.h_expect("a field name", self.h_tokens[self.h_offset]);
							}
						} else self.h_out_node = [gml_node.global_ref, l_d];
						break;
					case 26:
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected an opening square bracket", self.h_source.h_get_eof());
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_open) {
							self.h_offset += 1;
						} else return self.h_error("Expected an opening square bracket", self.h_tokens[self.h_offset]);
						if (self.h_build_expr(0)) return true;
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected a closing square bracket", self.h_source.h_get_eof());
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
							self.h_offset += 1;
						} else return self.h_error("Expected a closing square bracket", self.h_tokens[self.h_offset]);
						self.h_out_node = [gml_node.arg_index, l_tk0[1/* d */], self.h_out_node];
						break;
					case 27: self.h_out_node = [gml_node.arg_count, l_tk0[1/* d */]]; break;
					case 25:
						if (self.h_build_expr(l_flags)) return true;
						var l__g1 = self.h_out_node;
						if (l__g1[0]/* gml_node */ == gml_node.call) self.h_out_node = [gml_node.construct, l__g1[1/* d */], l__g1[2/* expr */], l__g1[3/* args */]]; else return self.h_expect("a callable value after `new`", l_tk0);
						break;
					case 24:
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected a function name or `(`", self.h_source.h_get_eof());
						var l_oldName = self.h_current_script;
						var l_oldScript = self.h_current_script_ref;
						l_i = 0;
						do {
							l_s = l_oldName + "+" + string(++l_i);
							l_n = array_length(self.h_scripts);
							while (--l_n >= 0) {
								if (self.h_scripts[l_n].h_name == l_s) break;
							}
						} until (l_n <= 0);
						var l_scrName;
						var l__g1 = self.h_tokens[self.h_offset];
						if (l__g1[0]/* gml_token */ == gml_token.ident) {
							var l__name = l__g1[2/* id */];
							self.h_offset += 1;
							l_scrName = l__name;
						} else l_scrName = undefined;
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected an opening `(`", self.h_source.h_get_eof());
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_open) {
							self.h_offset += 1;
						} else return self.h_error("Expected an opening `(`", self.h_tokens[self.h_offset]);
						if (self.h_build_script_args()) return true;
						var l_isConstructor = false;
						var l_tmp;
						if (self.h_offset < self.h_length) {
							var l__g1 = self.h_tokens[self.h_offset];
							if (l__g1[0]/* gml_token */ == gml_token.ident) l_tmp = l__g1[2/* id */] == "constructor"; else l_tmp = false;
						} else l_tmp = false;
						if (l_tmp) {
							l_isConstructor = true;
							self.h_offset += 1;
						}
						var l_argPrefix = self.h_build_script_args_prefix;
						var l_scr = self.h_add_script(l_s, self.h_build_script_args_map, self.h_build_script_args_argc, true, []);
						l_scr.h_is_constructor = l_isConstructor;
						self.h_build_script_args_map = undefined;
						self.h_current_script = l_s;
						self.h_current_script_ref = l_scr;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected function body", self.h_source.h_get_eof());
						l_tk = self.h_tokens[self.h_offset];
						if (l_tk[0]/* gml_token */ == gml_token.cub_open) var l__g1 = l_tk[1/* d */]; else return self.h_expect("a `{`", self.h_tokens[self.h_offset]);
						self.h_build_line();
						if (l_argPrefix != undefined) {
							array_push(l_argPrefix, self.h_out_node);
							l_scr.h_node = [gml_node.block, gml_std_haxe_enum_tools_getParameter(self.h_out_node, 0), l_argPrefix];
						} else l_scr.h_node = self.h_out_node;
						self.h_out_node = [gml_node.func_literal, l_tk0[1/* d */], l_s, false];
						self.h_current_script = l_oldName;
						self.h_current_script_ref = l_oldScript;
						break;
					default: if ((l_flags & 4) != 0) return self.h_expect("a statement", l_tk0); else return self.h_expect("a value", l_tk0);
				}
				break;
			default: if ((l_flags & 4) != 0) return self.h_expect("a statement", l_tk0); else return self.h_expect("a value", l_tk0);
		}
		l_proc = true;
		while (l_proc && self.h_offset < self.h_length) {
			l_tk = self.h_tokens[self.h_offset];
			switch (l_tk[0]) {
				case gml_token.adjfix:
					if ((l_flags & 2) == 0) {
						self.h_offset += 1;
						self.h_out_node = [gml_node.postfix, l_tk[1/* d */], self.h_out_node, l_tk[2/* inc */]];
						l_flags |= 2;
					} else if (l_tk[2/* inc */]) {
						return self.h_error_at("Unexpected `++`", l_tk[1/* d */]);
					} else return self.h_error_at("Unexpected `--`", l_tk[1/* d */]);
					break;
				case gml_token.period:
					if ((l_flags & 2) == 0) {
						self.h_offset += 1;
						var l__g = self.h_tokens[self.h_offset];
						if (l__g[0]/* gml_token */ == gml_token.ident) {
							l_s = l__g[2/* id */];
							self.h_offset += 1;
							self.h_out_node = [gml_node.field, l_tk[1/* d */], self.h_out_node, l_s];
						} else return self.h_error("Expected a field name", self.h_tokens[self.h_offset]);
					} else return self.h_error("Unexpected period", self.h_tokens[self.h_offset]);
					break;
				case gml_token.par_open:
					if ((l_flags & 2) == 0) {
						self.h_offset += 1;
						if (self.h_build_args(l_tk[1/* d */], false)) return true;
					} else return self.h_error_at("Unexpected `(`", l_tk[1/* d */]);
					break;
				case gml_token.sqb_open:
					var l_d4 = l_tk[1/* d */];
					if ((l_flags & 2) == 0) {
						self.h_offset += 1;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected an index", self.h_source.h_get_eof());
						l_node = self.h_out_node;
						switch (l_tk[2/* accessorChar */]) {
							case 124:
								if (self.h_build_expr(0)) return true;
								if (self.h_offset >= self.h_length) {
									return self.h_error_at("Expected a closing bracket", self.h_source.h_get_eof());
								} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
									self.h_offset += 1;
								} else return self.h_error("Expected a closing bracket", self.h_tokens[self.h_offset]);
								self.h_out_node = [gml_node.ds_list, l_d4, l_node, self.h_out_node];
								break;
							case 63:
								if (self.h_build_expr(0)) return true;
								if (self.h_offset >= self.h_length) {
									return self.h_error_at("Expected a closing bracket", self.h_source.h_get_eof());
								} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
									self.h_offset += 1;
								} else return self.h_error("Expected a closing bracket", self.h_tokens[self.h_offset]);
								self.h_out_node = [gml_node.ds_map, l_d4, l_node, self.h_out_node];
								break;
							case 35:
								if (self.h_build_expr(0)) return true;
								l_node2 = self.h_out_node;
								if (self.h_offset >= self.h_length) {
									return self.h_error_at("Expected a comma", self.h_source.h_get_eof());
								} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.comma) {
									self.h_offset += 1;
								} else return self.h_error("Expected a comma", self.h_tokens[self.h_offset]);
								if (self.h_build_expr(0)) return true;
								if (self.h_offset >= self.h_length) {
									return self.h_error_at("Expected a closing bracket", self.h_source.h_get_eof());
								} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
									self.h_offset += 1;
								} else return self.h_error("Expected a closing bracket", self.h_tokens[self.h_offset]);
								self.h_out_node = [gml_node.ds_grid, l_d4, l_node, l_node2, self.h_out_node];
								break;
							case 36:
								if (self.h_build_expr(0)) return true;
								if (self.h_offset >= self.h_length) {
									return self.h_error_at("Expected a closing bracket", self.h_source.h_get_eof());
								} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
									self.h_offset += 1;
								} else return self.h_error("Expected a closing bracket", self.h_tokens[self.h_offset]);
								self.h_out_node = [gml_node.key_id, l_d4, l_node, self.h_out_node];
								break;
							case 64:
								if (self.h_build_expr(0)) return true;
								if (self.h_offset >= self.h_length) return self.h_error_at("Expected comma or a closing bracket", self.h_source.h_get_eof());
								switch (self.h_tokens[self.h_offset][0]) {
									case gml_token.comma:
										self.h_offset += 1;
										l_node2 = self.h_out_node;
										if (self.h_build_expr(0)) return true;
										if (self.h_offset >= self.h_length) {
											return self.h_error_at("Expected a closing bracket", self.h_source.h_get_eof());
										} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
											self.h_offset += 1;
										} else return self.h_error("Expected a closing bracket", self.h_tokens[self.h_offset]);
										self.h_out_node = [gml_node.raw_id2d, l_d4, l_node, l_node2, self.h_out_node];
										break;
									case gml_token.sqb_close:
										self.h_offset += 1;
										self.h_out_node = [gml_node.raw_id, l_d4, l_node, self.h_out_node];
										break;
									default: self.h_expect("comma or a closing bracket", self.h_tokens[self.h_offset]);
								}
								break;
							case 0: l_proc = false; break;
							default: return self.h_error("Unknown accessor", l_tk);
						}
						if (!l_proc) {
							l_proc = true;
							if (self.h_build_expr(0)) return true;
							if (self.h_offset >= self.h_length) return self.h_error_at("Expected comma or a closing bracket", self.h_source.h_get_eof());
							switch (self.h_tokens[self.h_offset][0]) {
								case gml_token.comma:
									self.h_offset += 1;
									l_node2 = self.h_out_node;
									if (self.h_build_expr(0)) return true;
									if (self.h_offset >= self.h_length) {
										return self.h_error_at("Expected a closing bracket", self.h_source.h_get_eof());
									} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.sqb_close) {
										self.h_offset += 1;
									} else return self.h_error("Expected a closing bracket", self.h_tokens[self.h_offset]);
									self.h_out_node = [gml_node.index2d, l_d4, l_node, l_node2, self.h_out_node];
									break;
								case gml_token.sqb_close:
									self.h_offset += 1;
									self.h_out_node = [gml_node.index, l_d4, l_node, self.h_out_node];
									break;
								default: self.h_expect("comma or a closing bracket", self.h_tokens[self.h_offset]);
							}
						}
					} else return self.h_error_at("Unexpected `[`", l_d4);
					break;
				case gml_token.bin_op:
					if ((l_flags & 1) == 0) {
						if (self.h_build_ops(l_tk[1/* d */], l_tk[2/* op */])) return true;
						l_flags |= 2;
					} else l_proc = false;
					break;
				case gml_token.set_op:
					var l__g5 = l_tk[2/* op */];
					if (l__g5 == -1) {
						var l_p1 = l_tk[1/* d */];
						if ((l_flags & 4) != 0) {
							l_node = self.h_out_node;
							self.h_offset += 1;
							if (self.h_build_expr(0)) return true;
							self.h_out_node = [gml_node.set_op, l_p1, -1, l_node, self.h_out_node];
							l_proc = false;
						} else if ((l_flags & 1) == 0) {
							if (self.h_build_ops(l_p1, 64)) return true;
							l_flags |= 2;
						} else l_proc = false;
					} else {
						var l_o1 = l__g5;
						var l_p2 = l_tk[1/* d */];
						if ((l_flags & 4) != 0) {
							l_node = self.h_out_node;
							self.h_offset += 1;
							if (self.h_build_expr(0)) return true;
							self.h_out_node = [gml_node.set_op, l_p2, l_o1, l_node, self.h_out_node];
						}
						l_proc = false;
					}
					break;
				case gml_token.null_co:
					if ((l_flags & 1) == 0) {
						l_node = self.h_out_node;
						self.h_offset += 1;
						if (self.h_build_expr(0)) return true;
						l_flags |= 2;
						self.h_out_node = [gml_node.null_co, l_tk[1/* d */], l_node, self.h_out_node];
					} else l_proc = false;
					break;
				case gml_token.null_co_set:
					var l_p4 = l_tk[1/* d */];
					if ((l_flags & 4) != 0) {
						l_node = self.h_out_node;
						self.h_offset += 1;
						if (self.h_build_expr(0)) return true;
						self.h_out_node = [gml_node.set_op, l_p4, -1, gml_node_tools_clone(l_node), self.h_out_node];
						l_node2 = [gml_node.undefined_hx, l_p4];
						l_node = [gml_node.bin_op, l_p4, 64, l_node, l_node2];
						self.h_out_node = [gml_node.if_then, l_p4, l_node, self.h_out_node, undefined];
					}
					l_proc = false;
					break;
				case gml_token.qmark:
					if ((l_flags & 1) == 0) {
						self.h_offset += 1;
						l_node = self.h_out_node;
						if (self.h_build_expr(0)) return true;
						l_node2 = self.h_out_node;
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected an else-colon", self.h_source.h_get_eof());
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.colon) {
							self.h_offset += 1;
						} else return self.h_error("Expected an else-colon", self.h_tokens[self.h_offset]);
						if (self.h_build_expr(0)) return true;
						self.h_out_node = [gml_node.ternary, l_tk[1/* d */], l_node, l_node2, self.h_out_node];
					} else l_proc = false;
					break;
				default: l_proc = false;
			}
		}
		return false;
	}
	static h_build_line_inner = function(l_reqStatement) {
		if (self.h_offset >= self.h_length) return self.h_error_at("Expected a statement", self.h_source.h_get_eof());
		var l_tk = self.h_tokens[self.h_offset++];
		var l_tk2, l_proc, l_sep, l_x, l_x1, l_x2, l_nodes, l_i, l_s, l_d;
		var l_unknown = false;
		switch (l_tk[0]) {
			case gml_token.ident:
				if (l_tk[2/* id */] == "static") {
					var l_d = l_tk[1/* d */];
					var l__g = self.h_tokens[self.h_offset];
					if ((l__g[0] == 12)) {
						l_nodes = [];
						l_proc = true;
						while (l_proc && self.h_offset < self.h_length) {
							l_tk2 = self.h_tokens[self.h_offset++];
							switch (l_tk2[0]) {
								case gml_token.keyword: if (l_tk2[2/* kw */] == 2) var l_d1 = l_tk2[1/* d */]; else return self.h_expect("a static variable name", l_tk2); break;
								case gml_token.ident:
									var l_id = l_tk2[2/* id */];
									if (self.h_offset >= self.h_length) return self.h_error_at("Expected a static variable value", self.h_source.h_get_eof());
									l_tk = self.h_tokens[self.h_offset];
									if (self.h_offset >= self.h_length) {
										return self.h_error_at("Expected a static variable value", self.h_source.h_get_eof());
									} else {
										var l__g = self.h_tokens[self.h_offset];
										if (l__g[0]/* gml_token */ == gml_token.set_op) {
											if (l__g[2/* op */] == -1) self.h_offset += 1; else return self.h_error("Expected a static variable value", self.h_tokens[self.h_offset]);
										} else return self.h_error("Expected a static variable value", self.h_tokens[self.h_offset]);
									}
									if (self.h_build_expr(0)) return true;
									var l_scr = self.h_current_script_ref;
									if (variable_struct_exists(l_scr.h_static_map, l_id)) return self.h_error("Re-declaration of static variable " + l_id, l_tk2);
									array_push(l_scr.h_static_names, l_id);
									l_scr.h_static_map[$ l_id] = l_scr.h_static_count++;
									array_push(l_scr.h_static_init, [gml_node.static_set, l_tk2[1/* d */], l_id, self.h_out_node, true]);
									array_push(l_scr.h_static_values, undefined);
									if (self.h_offset < self.h_length) switch (self.h_tokens[self.h_offset][0]) {
										case gml_token.comma: self.h_offset += 1; break;
										case gml_token.semico:
											self.h_offset += 1;
											l_proc = false;
											break;
										default: l_proc = false;
									}
									break;
								default: return self.h_expect("a static variable name", l_tk2);
							}
						}
						if (array_length(l_nodes) != 1) self.h_out_node = [gml_node.block, l_d, l_nodes]; else self.h_out_node = l_nodes[0];
					} else l_unknown = true;
				} else l_unknown = true;
				break;
			case gml_token.keyword:
				var l__g = l_tk[1/* d */];
				switch (l_tk[2/* kw */]) {
					case 1:
						l_d = l__g;
						l_nodes = [];
						l_x1 = [gml_node.block, l_d, l_nodes];
						while (self.h_offset < self.h_length) {
							l_tk2 = self.h_tokens[self.h_offset++];
							if (l_tk2[0]/* gml_token */ == gml_token.ident) {
								l_d = l_tk2[1/* d */];
								l_s = l_tk2[2/* id */];
								array_push(self.h_global_vars, l_s);
								l_i = array_length(self.h_macro_names);
								self.h_macro_names[@l_i] = l_s;
								self.h_macro_nodes[@l_i] = new gml_macro(l_s, [gml_node.global_hx, l_d, l_s], true, false);
								var l__g1 = self.h_tokens[self.h_offset];
								if (l__g1[0]/* gml_token */ == gml_token.set_op) {
									if (l__g1[2/* op */] == -1) {
										self.h_offset += 1;
										if (self.h_build_expr(0)) return true;
										l_x = [gml_node.global_set, l_d, l_s, self.h_out_node];
										array_push(l_nodes, l_x);
									}
								}
								if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.comma) {
									self.h_offset += 1;
									continue;
								}
							} else return self.h_error("Expected a global variable name.", l_tk2);
							break;
						}
						self.h_out_node = l_x1;
						break;
					case 2:
						var l_d = l__g;
						l_nodes = [];
						l_proc = true;
						while (l_proc && self.h_offset < self.h_length) {
							l_tk2 = self.h_tokens[self.h_offset++];
							switch (l_tk2[0]) {
								case gml_token.keyword: if (l_tk2[2/* kw */] == 2) var l_d1 = l_tk2[1/* d */]; else return self.h_expect("a variable name", l_tk2); break;
								case gml_token.ident:
									if (self.h_offset >= self.h_length) return self.h_error_at("Expected a variable value", self.h_source.h_get_eof());
									l_tk = self.h_tokens[self.h_offset];
									if (l_tk[0]/* gml_token */ == gml_token.set_op) {
										if (l_tk[2/* op */] == -1) {
											self.h_offset += 1;
											if (self.h_build_expr(0)) return true;
										} else self.h_out_node = undefined;
									} else self.h_out_node = undefined;
									array_push(l_nodes, [gml_node.var_decl, l_tk2[1/* d */], l_tk2[2/* id */], self.h_out_node]);
									if (self.h_offset < self.h_length) switch (self.h_tokens[self.h_offset][0]) {
										case gml_token.comma: self.h_offset += 1; break;
										case gml_token.semico:
											self.h_offset += 1;
											l_proc = false;
											break;
										default: l_proc = false;
									}
									break;
								default: return self.h_expect("a variable name", l_tk2);
							}
						}
						if (array_length(l_nodes) != 1) self.h_out_node = [gml_node.block, l_d, l_nodes]; else self.h_out_node = l_nodes[0];
						break;
					case 3:
						var l_e;
						var l__g1 = self.h_tokens[self.h_offset];
						if (l__g1[0]/* gml_token */ == gml_token.ident) {
							var l_d1 = l__g1[1/* d */];
							var l_s1 = l__g1[2/* id */];
							self.h_offset += 1;
							l_e = new gml_enum(l_s1, l_d1);
						} else return self.h_error("Expected an enum name", self.h_tokens[self.h_offset]);
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected enum block", self.h_source.h_get_eof());
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.cub_open) {
							self.h_offset += 1;
						} else return self.h_error("Expected enum block", self.h_tokens[self.h_offset]);
						l_proc = true;
						l_sep = true;
						while (self.h_offset < self.h_length && l_proc) {
							var l__g1 = self.h_tokens[self.h_offset];
							switch (l__g1[0]) {
								case gml_token.cub_close:
									self.h_offset += 1;
									l_proc = false;
									break;
								case gml_token.comma:
									if (l_sep) {
										return self.h_error("Unexpected comma", self.h_tokens[self.h_offset]);
									} else {
										self.h_offset += 1;
										l_sep = true;
									}
									break;
								case gml_token.ident:
									if (l_sep) {
										self.h_offset += 1;
										var l__g3 = self.h_tokens[self.h_offset];
										if (l__g3[0]/* gml_token */ == gml_token.set_op) {
											if (l__g3[2/* op */] == -1) {
												self.h_offset += 1;
												if (self.h_build_expr(0)) return true;
											} else self.h_out_node = undefined;
										} else self.h_out_node = undefined;
										var l_ec = new gml_enum_ctr(l__g1[2/* id */], l__g1[1/* d */], self.h_out_node);
										array_push(l_e.h_ctr_list, l_ec);
										l_e.h_ctr_map[$ l_ec.h_name] = l_ec;
										l_sep = false;
									} else return self.h_expect("a comma or a closing bracket", self.h_tokens[self.h_offset]);
									break;
								default: return self.h_expect("a comma, enum entry, or closing bracket", self.h_tokens[self.h_offset]);
							}
						}
						if (l_proc) return self.h_error("Unclosed enum-block", l_tk);
						array_push(self.h_enums, l_e);
						self.h_out_node = [gml_node.block, l__g, []];
						break;
					case 4:
						if (self.h_build_expr(0)) return true;
						l_x1 = self.h_out_node;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected a then-expression", self.h_source.h_get_eof());
						var l__g1 = self.h_tokens[self.h_offset];
						if (l__g1[0]/* gml_token */ == gml_token.keyword) {
							if (l__g1[2/* kw */] == 5) self.h_offset += 1;
						}
						if (self.h_build_line()) return true;
						l_x2 = self.h_out_node;
						l_i = self.h_offset;
						if (self.h_offset < self.h_length) {
							var l__g1 = self.h_tokens[self.h_offset];
							if (l__g1[0]/* gml_token */ == gml_token.keyword) {
								if (l__g1[2/* kw */] == 6) {
									self.h_offset += 1;
									if (self.h_build_line()) return true;
									l_x = self.h_out_node;
								} else {
									self.h_offset = l_i;
									l_x = undefined;
								}
							} else {
								self.h_offset = l_i;
								l_x = undefined;
							}
						} else {
							self.h_offset = l_i;
							l_x = undefined;
						}
						self.h_out_node = [gml_node.if_then, l__g, l_x1, l_x2, l_x];
						break;
					case 7:
						var l_d = l__g;
						if (self.h_build_expr(0)) return true;
						l_x1 = self.h_out_node;
						var l_cc = [];
						var l_c = undefined;
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected switch-block body", self.h_source.h_get_eof());
						} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.cub_open) {
							self.h_offset += 1;
						} else return self.h_error("Expected switch-block body", self.h_tokens[self.h_offset]);
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected switch-block contents", self.h_source.h_get_eof());
						var l__g1 = self.h_tokens[self.h_offset];
						if (l__g1[0]/* gml_token */ == gml_token.keyword) switch (l__g1[2/* kw */]) {
							case 8: case 9: break;
							default: return self.h_expect("`case` or `default`", self.h_tokens[self.h_offset]);
						} else return self.h_expect("`case` or `default`", self.h_tokens[self.h_offset]);
						l_proc = true;
						l_x2 = undefined;
						l_nodes = undefined;
						var l_pre = [];
						while (self.h_offset < self.h_length && l_proc) {
							var l__g1 = self.h_tokens[self.h_offset];
							switch (l__g1[0]) {
								case gml_token.cub_close:
									self.h_offset += 1;
									l_proc = false;
									break;
								case gml_token.keyword:
									switch (l__g1[2/* kw */]) {
										case 8:
											self.h_offset += 1;
											if (self.h_build_expr(0)) return true;
											if (self.h_offset >= self.h_length) {
												return self.h_error_at("Expected a colon", self.h_source.h_get_eof());
											} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.colon) {
												self.h_offset += 1;
											} else return self.h_error("Expected a colon", self.h_tokens[self.h_offset]);
											l_nodes = [self.h_out_node];
											while (self.h_offset < self.h_length) {
												var l__g5 = self.h_tokens[self.h_offset];
												if (l__g5[0]/* gml_token */ == gml_token.keyword) {
													if (l__g5[2/* kw */] == 8) {
														self.h_offset += 1;
														if (self.h_build_expr(0)) return true;
														if (self.h_offset >= self.h_length) {
															return self.h_error_at("Expected a colon", self.h_source.h_get_eof());
														} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.colon) {
															self.h_offset += 1;
														} else return self.h_error("Expected a colon", self.h_tokens[self.h_offset]);
														array_push(l_nodes, self.h_out_node);
														continue;
													}
												}
												break;
											}
											l_c = { values: l_nodes, expr: undefined, pre: l_pre }
											array_push(l_cc, l_c);
											l_nodes = [];
											l_pre = [];
											l_c.expr = [gml_node.block, l__g1[1/* d */], l_nodes];
											break;
										case 9:
											self.h_offset += 1;
											if (self.h_offset >= self.h_length) {
												return self.h_error_at("Expected a colon", self.h_source.h_get_eof());
											} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.colon) {
												self.h_offset += 1;
											} else return self.h_error("Expected a colon", self.h_tokens[self.h_offset]);
											l_nodes = [];
											l_x2 = [gml_node.block, l__g1[1/* d */], l_nodes];
											break;
										default:
											if (self.h_build_line()) return true;
											array_push(l_nodes, self.h_out_node);
									}
									break;
								default:
									if (self.h_build_line()) return true;
									array_push(l_nodes, self.h_out_node);
							}
						}
						if (l_proc) return self.h_error_at("Unclosed switch-block", l_d);
						self.h_out_node = [gml_node.switch_hx, l_d, l_x1, l_cc, l_x2];
						break;
					case 14:
						var l_d = l__g;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected for-loop header", self.h_source.h_get_eof());
						if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_open) {
							self.h_offset += 1;
							l_proc = true;
						} else l_proc = false;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected for-loop init", self.h_source.h_get_eof());
						if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.semico) {
							self.h_offset += 1;
							l_x = [gml_node.block, l_d, []];
						} else {
							if (self.h_build_line_inner(true)) return true;
							l_x = self.h_out_node;
							if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.semico) self.h_offset += 1;
						}
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected for-loop condition", self.h_source.h_get_eof());
						if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.semico) {
							self.h_offset += 1;
							l_x1 = [gml_node.boolean, l_d, true];
						} else {
							if (self.h_build_expr(0)) return true;
							l_x1 = self.h_out_node;
							if (self.h_offset >= self.h_length) return self.h_error_at("Expected for-loop post-action", self.h_source.h_get_eof());
							if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.semico) self.h_offset += 1;
						}
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected for-loop post-action", self.h_source.h_get_eof());
						if (l_proc) {
							if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_close) {
								self.h_offset += 1;
								l_proc = false;
								l_x2 = [gml_node.block, l_d, []];
							} else {
								if (self.h_build_line()) return true;
								l_x2 = self.h_out_node;
							}
						} else {
							if (self.h_build_line()) return true;
							l_x2 = self.h_out_node;
						}
						if (l_proc) {
							if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_close) self.h_offset += 1; else return self.h_expect("a closing parenthesis", self.h_tokens[self.h_offset]);
						}
						if (self.h_build_line()) return true;
						self.h_out_node = [gml_node.for_hx, l_d, l_x, l_x1, l_x2, self.h_out_node];
						break;
					case 11:
						if (self.h_build_expr(0)) return true;
						l_x1 = self.h_out_node;
						if (self.h_build_line()) return true;
						self.h_out_node = [gml_node.while_hx, l__g, l_x1, self.h_out_node];
						break;
					case 10:
						if (self.h_build_expr(0)) return true;
						l_x1 = self.h_out_node;
						if (self.h_build_line()) return true;
						self.h_out_node = [gml_node.repeat_hx, l__g, l_x1, self.h_out_node];
						break;
					case 13:
						var l_d = l__g;
						if (self.h_build_line()) return true;
						l_x1 = self.h_out_node;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected a `while` or `until`", self.h_source.h_get_eof());
						var l__g1 = self.h_tokens[self.h_offset];
						if (l__g1[0]/* gml_token */ == gml_token.keyword) switch (l__g1[2/* kw */]) {
							case 11:
								self.h_offset += 1;
								if (self.h_build_expr(0)) return true;
								self.h_out_node = [gml_node.do_while, l_d, l_x1, self.h_out_node];
								break;
							case 12:
								self.h_offset += 1;
								if (self.h_build_expr(0)) return true;
								self.h_out_node = [gml_node.do_until, l_d, l_x1, self.h_out_node];
								break;
							default: return self.h_expect("a `while` or `until`", self.h_tokens[self.h_offset]);
						} else return self.h_expect("a `while` or `until`", self.h_tokens[self.h_offset]);
						break;
					case 15:
						if (self.h_build_expr(0)) return true;
						l_x1 = self.h_out_node;
						if (self.h_build_line()) return true;
						self.h_out_node = [gml_node.with_hx, l__g, l_x1, self.h_out_node];
						break;
					case 17: self.h_out_node = [gml_node.break_hx, l__g]; break;
					case 16: self.h_out_node = [gml_node.continue_hx, l__g]; break;
					case 19: self.h_out_node = [gml_node.exit_hx, l__g]; break;
					case 18:
						var l_d = l__g;
						if (self.h_offset < self.h_length) {
							var l__g1 = self.h_tokens[self.h_offset];
							switch (l__g1[0]) {
								case gml_token.semico: self.h_out_node = [gml_node.exit_hx, l__g1[1/* d */]]; break;
								case gml_token.cub_close: self.h_out_node = [gml_node.exit_hx, l__g1[1/* d */]]; break;
								default:
									if (self.h_build_expr(0)) return true;
									self.h_out_node = [gml_node.return_hx, l_d, self.h_out_node];
							}
						} else self.h_out_node = [gml_node.exit_hx, l_d];
						break;
					case 29:
						if (self.h_build_expr(0)) return true;
						self.h_out_node = [gml_node.delete_hx, l__g, self.h_out_node];
						break;
					case 20:
						if (self.h_build_expr(0)) return true;
						self.h_out_node = [gml_node.wait, l__g, self.h_out_node];
						break;
					case 28: self.h_out_node = [gml_node.debugger, l__g]; break;
					case 21:
						if (self.h_build_line()) return true;
						l_x1 = self.h_out_node;
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected a catch-block", self.h_source.h_get_eof());
						} else {
							var l__g1 = self.h_tokens[self.h_offset];
							if (l__g1[0]/* gml_token */ == gml_token.keyword) {
								if (l__g1[2/* kw */] == 22) self.h_offset += 1; else return self.h_error("Expected a catch-block", self.h_tokens[self.h_offset]);
							} else return self.h_error("Expected a catch-block", self.h_tokens[self.h_offset]);
						}
						if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_open) {
							self.h_offset += 1;
							l_proc = true;
						} else l_proc = false;
						if (self.h_offset >= self.h_length) {
							return self.h_error_at("Expected a capture variable name", self.h_source.h_get_eof());
						} else {
							var l__g1 = self.h_tokens[self.h_offset];
							if (l__g1[0]/* gml_token */ == gml_token.ident) {
								self.h_offset += 1;
								l_s = l__g1[2/* id */];
							} else return self.h_error("Expected a capture variable name", self.h_tokens[self.h_offset]);
						}
						if (l_proc) {
							if (self.h_offset >= self.h_length) {
								return self.h_error_at("Expected a closing parenthesis", self.h_source.h_get_eof());
							} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_close) {
								self.h_offset += 1;
							} else return self.h_error("Expected a closing parenthesis", self.h_tokens[self.h_offset]);
						}
						if (self.h_build_line()) return true;
						self.h_out_node = [gml_node.try_catch, l__g, l_x1, l_s, self.h_out_node];
						break;
					case 23:
						if (self.h_build_expr(0)) return true;
						self.h_out_node = [gml_node.throw_hx, l__g, self.h_out_node];
						break;
					default: l_unknown = true;
				}
				break;
			case gml_token.macro_start:
				var l__g = self.h_tokens[self.h_offset++];
				if (l__g[0]/* gml_token */ == gml_token.ident) {
					var l_s1 = l__g[2/* id */];
					var l_add;
					if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.colon) {
						self.h_offset += 1;
						l_add = l_s1 == live_config;
						var l__g = self.h_tokens[self.h_offset++];
						if (l__g[0]/* gml_token */ == gml_token.ident) l_s1 = l__g[2/* id */]; else return self.h_error("Expected a macro name", self.h_tokens[self.h_offset]);
					} else l_add = true;
					if (self.h_build_expr(0)) return true;
					if (l_add) {
						var l_i1 = gml_std_gml_internal_ArrayImpl_indexOf(self.h_macro_names, l_s1);
						if (l_i1 < 0) {
							l_i1 = array_length(self.h_macro_names);
							self.h_macro_names[@l_i1] = l_s1;
						}
						self.h_macro_nodes[@l_i1] = new gml_macro(l_s1, self.h_out_node, true, gml_node_tools_is_statement(self.h_out_node));
					}
					self.h_out_node = [gml_node.block, l_tk[1/* d */], []];
				} else return self.h_error("Expected a macro name", self.h_tokens[self.h_offset]);
				break;
			case gml_token.cub_open:
				var l_start = l_tk[1/* d */];
				if (!l_reqStatement) switch (self.h_tokens[self.h_offset][0]) {
					case gml_token.cstring:
						self.h_offset -= 1;
						return self.h_build_expr(0);
					case gml_token.ident:
						if (self.h_offset + 1 < self.h_length) {
							if (self.h_tokens[self.h_offset + 1][0]/* gml_token */ == gml_token.colon) {
								self.h_offset -= 1;
								return self.h_build_expr(0);
							}
						}
						break;
				}
				l_proc = true;
				l_nodes = [];
				while (l_proc && self.h_offset < self.h_length) {
					if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.cub_close) {
						self.h_offset += 1;
						l_proc = false;
					} else {
						if (self.h_build_line()) return true;
						array_push(l_nodes, self.h_out_node);
					}
				}
				if (l_proc) return self.h_error_at("Expected a closing bracket.", l_start);
				self.h_out_node = [gml_node.block, l_start, l_nodes];
				break;
			default: l_unknown = true;
		}
		if (l_unknown) {
			self.h_offset -= 1;
		} else {
			gml_builder_build_line_is_stat = true;
			gml_builder_build_line_is_expr = false;
		}
		if (l_unknown) {
			var l_flags = 4;
			if (l_reqStatement) l_flags |= 1;
			if (self.h_build_expr(l_flags)) return true;
			gml_builder_build_line_is_stat = gml_node_tools_is_statement(self.h_out_node);
			gml_builder_build_line_is_expr = true;
			if (l_reqStatement && !gml_builder_build_line_is_stat) return self.h_expect_node("a statement", self.h_out_node);
		}
		return false;
	}
	static h_build_line = function(l_reqStatement) {
		if (l_reqStatement == undefined) l_reqStatement = true;
		if (false) __show_debug_message_base(argument[0]);
		if (self.h_build_line_inner(l_reqStatement)) return true;
		while (self.h_offset < self.h_length) {
			if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.semico) {
				self.h_offset += 1;
				continue;
			}
			break;
		}
		return false;
	}
	static h_build_top_level_script = function(l_name, l_namedArgs, l_namedArgc, l_isFunc, l_prefixStatements) {
		return self.h_build_top_level_script_body(self.h_add_script(l_name, l_namedArgs, l_namedArgc, l_isFunc, l_prefixStatements));
	}
	static h_add_script = function(l_name, l_namedArgs, l_namedArgc, l_isFunc, l_prefixStatements) {
		var l_scr = new gml_script(self.h_source, l_name, (self.h_offset >= self.h_length ? self.h_source.h_get_eof() : self.h_tokens[self.h_offset][1]));
		if (l_namedArgs == undefined) l_namedArgs = { }
		l_scr.h_named_args = l_namedArgs;
		l_scr.h_arguments = l_namedArgc;
		l_scr.h_is_function = l_isFunc;
		l_scr.h_prefix_statements = l_prefixStatements;
		array_push(self.h_scripts, l_scr);
		return l_scr;
	}
	static h_build_top_level_script_body = function(l_scr) {
		if (compile_groups_gml_compile_group_static_has_statics) {
			var l_fn = gml_func_map[$ l_scr.h_name];
			if (l_fn != undefined) l_scr.h_script_id = l_fn.h_raw_func;
		}
		var l_prefixStatements = l_scr.h_prefix_statements;
		l_scr.h_prefix_statements = undefined;
		var l__scriptName = self.h_current_script;
		var l__scriptRef = self.h_current_script_ref;
		self.h_current_script = l_scr.h_name;
		self.h_current_script_ref = l_scr;
		var l_nodes;
		if (l_scr.h_is_function) {
			if (self.h_build_line()) return true;
			var l_scrNode = self.h_out_node;
			if (l_prefixStatements != undefined) {
				array_push(l_prefixStatements, l_scrNode);
				l_scrNode = [gml_node.block, gml_std_haxe_enum_tools_getParameter(l_scrNode, 0), l_prefixStatements];
			}
			l_scr.h_node = l_scrNode;
			l_scr = self.h_scripts[0];
			var l__g = l_scr.h_node;
			if (l__g[0]/* gml_node */ == gml_node.block) l_nodes = l__g[2/* nodes */]; else l_nodes = [l_scr.h_node];
		} else if (l_prefixStatements != undefined) {
			l_nodes = l_prefixStatements;
		} else l_nodes = [];
		while (self.h_offset < self.h_length) {
			var l__g = self.h_tokens[self.h_offset];
			switch (l__g[0]) {
				case gml_token.header: break;
				case gml_token.keyword:
					if (l__g[2/* kw */] != 24) {
						if (self.h_build_line()) return true;
						array_push(l_nodes, self.h_out_node);
						continue;
					}
					break;
				default:
					if (self.h_build_line()) return true;
					array_push(l_nodes, self.h_out_node);
					continue;
			}
			break;
		}
		if (array_length(l_nodes) > 1) {
			l_scr.h_node = [gml_node.block, gml_std_haxe_enum_tools_getParameter(l_nodes[0], 0), l_nodes];
		} else if (array_length(l_nodes) == 1) {
			l_scr.h_node = l_nodes[0];
		} else l_scr.h_node = [gml_node.block, self.h_source.h_get_eof(), l_nodes];
		self.h_current_script = l__scriptName;
		self.h_current_script_ref = l__scriptRef;
		return false;
	}
	static h_build_script_args = function() {
		var l_nextArgs = { }
		var l_nextArgc = 0;
		var l_proc = true;
		var l_nextPrefix = undefined;
		if (self.h_offset >= self.h_length) return self.h_error_at("Expected script arguments", self.h_source.h_get_eof());
		var l__g = self.h_tokens[self.h_offset];
		if ((l__g[0] == 22)) {
			self.h_offset += 1;
		} else while (l_proc && self.h_offset < self.h_length) {
			var l__g = self.h_tokens[self.h_offset];
			if (l__g[0]/* gml_token */ == gml_token.ident) {
				var l_argName = l__g[2/* id */];
				var l_nextArg = l_argName;
				if (variable_struct_exists(l_nextArgs, l_nextArg)) return self.h_error("An argument named " + l_nextArg + " is already defined at position " + gml_std_Std_stringify(l_nextArgs[$ l_nextArg]), self.h_tokens[self.h_offset]);
				var l_argIndex = l_nextArgc++;
				l_nextArgs[$ l_argName] = l_argIndex;
				self.h_offset += 1;
				var l__g2 = self.h_tokens[self.h_offset];
				if (l__g2[0]/* gml_token */ == gml_token.set_op) {
					if (l__g2[2/* op */] == -1) {
						var l_defPos = l__g2[1/* d */];
						self.h_offset += 1;
						if (self.h_build_expr(0)) return true;
						var l_ifNode = [gml_node.if_then, l_defPos, [gml_node.bin_op, l_defPos, 64, [gml_node.arg_const, l_defPos, l_argIndex], [gml_node.undefined_hx, l_defPos]], [gml_node.set_op, l_defPos, -1, [gml_node.arg_const, l_defPos, l_argIndex], self.h_out_node], undefined];
						if (l_nextPrefix == undefined) l_nextPrefix = [];
						array_push(l_nextPrefix, l_ifNode);
					}
				}
				switch (self.h_tokens[self.h_offset][0]) {
					case gml_token.par_close:
						self.h_offset += 1;
						l_proc = false;
						break;
					case gml_token.comma: self.h_offset += 1; break;
					default: return self.h_expect("a comma or closing parenthesis in script arguments", self.h_tokens[self.h_offset]);
				}
			} else return self.h_expect("an argument", self.h_tokens[self.h_offset]);
		}
		self.h_build_script_args_map = l_nextArgs;
		self.h_build_script_args_argc = l_nextArgc;
		self.h_build_script_args_prefix = l_nextPrefix;
		return false;
	}
	static h_build_script_args_prefix = undefined; /// @is {array<ast_GmlNode>}
	static h_build_script_args_map = undefined; /// @is {tools_Dictionary<int>}
	static h_build_script_args_argc = undefined; /// @is {int}
	static h_build_inherit = function() {
		if (self.h_offset >= self.h_length) return self.h_error_at("Expected a parent function name", self.h_source.h_get_eof());
		var l_tk = self.h_tokens[self.h_offset++];
		switch (l_tk[0]) {
			case gml_token.ident:
				self.h_build_inherit_is_global = false;
				self.h_build_inherit_parent = l_tk[2/* id */];
				break;
			case gml_token.keyword:
				if (l_tk[2/* kw */] == 0) {
					if (self.h_offset >= self.h_length) {
						return self.h_error_at("Expected a `.` after `global.`", self.h_source.h_get_eof());
					} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.period) {
						self.h_offset += 1;
					} else return self.h_error("Expected a `.` after `global.`", self.h_tokens[self.h_offset]);
					if (self.h_offset >= self.h_length) {
						return self.h_error_at("Expected a global variable name", self.h_source.h_get_eof());
					} else {
						var l__g = self.h_tokens[self.h_offset];
						if (l__g[0]/* gml_token */ == gml_token.ident) {
							self.h_offset += 1;
							self.h_build_inherit_is_global = true;
							self.h_build_inherit_parent = l__g[2/* id */];
						} else return self.h_error("Expected a global variable name", self.h_tokens[self.h_offset]);
					}
				} else return self.h_expect("a parent function name", l_tk);
				break;
			default: return self.h_expect("a parent function name", l_tk);
		}
		if (self.h_offset >= self.h_length) {
			return self.h_error_at("Expected an opening `(` for inheritance call", self.h_source.h_get_eof());
		} else if (self.h_tokens[self.h_offset][0]/* gml_token */ == gml_token.par_open) {
			self.h_offset += 1;
		} else return self.h_error("Expected an opening `(` for inheritance call", self.h_tokens[self.h_offset]);
		if (self.h_build_script_args()) return true;
		return false;
	}
	static h_build_inherit_is_global = undefined; /// @is {bool}
	static h_build_inherit_parent = undefined; /// @is {string}
	static h_build_loop = function(l_first) {
		if (self.h_build_top_level_script(l_first, undefined, 0, false, undefined)) return true;
		var l_hasFirstFunc = false;
		while (self.h_offset < self.h_length) {
			var l_tk = self.h_tokens[self.h_offset];
			switch (l_tk[0]) {
				case gml_token.header:
					self.h_offset += 1;
					var l_nextName = l_tk[2/* name */];
					var l_nextArgs = undefined;
					var l_nextArgc = 0;
					var l_nextPrefix = undefined;
					if (!(l_tk[3/* lb */] || self.h_offset >= self.h_length)) {
						var l__g1 = self.h_tokens[self.h_offset];
						if ((l__g1[0] == 21)) {
							self.h_offset += 1;
							if (self.h_build_script_args()) return true;
							l_nextArgs = self.h_build_script_args_map;
							l_nextArgc = self.h_build_script_args_argc;
							l_nextPrefix = self.h_build_script_args_prefix;
							self.h_build_script_args_map = undefined;
						}
					}
					if (self.h_build_top_level_script(l_nextName, l_nextArgs, l_nextArgc, false, l_nextPrefix)) return true;
					break;
				case gml_token.keyword:
					if (l_tk[2/* kw */] == 24) {
						self.h_offset += 1;
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected a function name", self.h_source.h_get_eof());
						var l_nextName1;
						l_tk = self.h_tokens[self.h_offset];
						if (l_tk[0]/* gml_token */ == gml_token.ident) {
							l_nextName1 = l_tk[2/* id */];
							self.h_offset += 1;
						} else if (l_hasFirstFunc) {
							return self.h_expect("a function name", l_tk);
						} else {
							l_hasFirstFunc = true;
							l_nextName1 = l_first;
						}
						if (self.h_offset >= self.h_length) return self.h_error_at("Expected an opening `(`", self.h_source.h_get_eof());
						l_tk = self.h_tokens[self.h_offset++];
						if (!(l_tk[0] == 21)) return self.h_expect("an opening `(`", l_tk);
						if (self.h_build_script_args()) return true;
						var l_nextArgs1 = self.h_build_script_args_map;
						self.h_build_script_args_map = undefined;
						var l_scr = self.h_add_script(l_nextName1, l_nextArgs1, self.h_build_script_args_argc, true, self.h_build_script_args_prefix);
						if (self.h_offset < self.h_length) {
							l_tk = self.h_tokens[self.h_offset];
							if ((l_tk[0] == 7)) {
								self.h_offset += 1;
								l_scr.h_is_constructor = true;
								if (self.h_build_inherit()) return true;
								l_scr.h_parent_name = self.h_build_inherit_parent;
								l_scr.h_parent_is_global = self.h_build_inherit_is_global;
								l_scr.h_parent_argc = self.h_build_script_args_argc;
								self.h_build_script_args_map = undefined;
							} else {
								var l_tmp3;
								if (l_tk[0]/* gml_token */ == gml_token.ident) l_tmp3 = l_tk[2/* id */] == "constructor"; else l_tmp3 = false;
								if (l_tmp3) {
									self.h_offset += 1;
									l_scr.h_is_constructor = true;
								}
							}
						}
						if (self.h_build_top_level_script_body(l_scr)) return true;
					} else return self.h_expect("A script declaration", l_tk);
					break;
				default: return self.h_expect("A script declaration", l_tk);
			}
		}
		return false;
	}
	static h_program = undefined; /// @is {gml_program}
	static h_dump = function() {
		var l_i = 0;
		for (var l__g1 = self.h_length; l_i < l__g1; l_i++) {
			var l_tmp = string(l_i) + "\t";
			var l_q = self.h_tokens[l_i];
			var l_pg = self.h_program;
			var l_n = gml_std_haxe_enum_tools_getParameterCount(l_q);
			var l_r = g_gml_token_constructors[l_q[0]] + "(" + gml_pos_to_string(l_q[1], l_pg);
			var l_i1 = 1;
			for (var l__g3 = l_n; l_i1 < l__g3; l_i1++) {
				l_r += ", " + gml_std_Std_stringify(gml_std_haxe_enum_tools_getParameter(l_q, l_i1));
			}
			__show_debug_message_base(l_tmp + (l_r + ")"));
		}
	}
	self.h_build_inherit_parent = undefined;
	self.h_build_inherit_is_global = false;
	self.h_build_script_args_argc = 0;
	self.h_build_script_args_map = undefined;
	self.h_build_script_args_prefix = [];
	self.h_current_script_ref = undefined;
	self.h_current_script = undefined;
	self.h_error_text = undefined;
	self.h_global_vars = [];
	self.h_macro_nodes = [];
	self.h_macro_names = [];
	self.h_enums = [];
	self.h_scripts = [];
	self.h_offset = 0;
	self.h_program = l_pg;
	self.h_source = l_src;
	var l_parser = l_src.h_parser;
	if (l_parser != undefined && l_parser.h_tokens != undefined) {
		self.h_tokens = l_parser.h_tokens;
		self.h_length = l_parser.h_token_count;
	} else {
		l_parser = new gml_parser(l_src);
		l_src.h_parser = l_parser;
		self.h_tokens = l_parser.h_run();
		if (self.h_tokens != undefined) {
			self.h_length = l_parser.h_token_count;
		} else {
			self.h_error_text = gml_parser_error_text;
			self.h_error_pos = gml_parser_error_pos;
		}
	}
	static __class__ = mt_gml_builder;
}

#endregion
