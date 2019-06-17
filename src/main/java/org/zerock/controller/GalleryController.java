package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.service.GalleryService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/gallery/*")
public class GalleryController {
	
	@Autowired
	GalleryService galleryService;
	
	@GetMapping("list")
	public void list(Model model) {
		model.addAttribute("galleryList", galleryService.getList());
		log.info("/gallery/list call...");
	}
	
	// @PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public void regster () {
		log.info("gallery register ... ");
	}

}
