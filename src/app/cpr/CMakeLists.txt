if(NOT DRISHTI_BUILD_MIN_SIZE)

  add_executable(drishti_train_cpr train_cpr.cpp RecipeIO.h RecipeIO.cpp EyeIO.h EyeIO.cpp)
  target_link_libraries(drishti_train_cpr drishtisdk cxxopts::cxxopts
    Boost::system
    Boost::filesystem      
    )

  if(DRISHTI_USE_IMSHOW)
    target_link_libraries(drishti_train_cpr imshow::imshow)
    target_compile_definitions(drishti_train_cpr PUBLIC DRISHTI_USE_IMSHOW)
  endif()
  
  set_property(TARGET drishti_train_cpr PROPERTY FOLDER "app/console")
  install(TARGETS drishti_train_cpr DESTINATION bin)

  if(DRISHTI_BUILD_TESTS AND NOT (IOS OR ANDROID))

    enable_testing()

    set(eye_src_model_private "${DRISHTI_FACES_EYE_MODEL}")
    set(eye_src_image_private "${DRISHTI_FACES_EYE_IMAGE}")
    
    set(eye_src_model "${CMAKE_CURRENT_BINARY_DIR}/2318-eye.json")    
    set(eye_src_image "${CMAKE_CURRENT_BINARY_DIR}/2318-eye.png")    
    set(eye_src_train_xml "${CMAKE_CURRENT_BINARY_DIR}/eye_train.xml")

    set(eye_recipe_json "${CMAKE_CURRENT_BINARY_DIR}/eye_recipe.json")
    set(eye_out_model "${CMAKE_CURRENT_BINARY_DIR}/eye.cpb")

    # Rename + copy image + model file side-by-side to meet eyexml requirements:
    #
    # dir/some_eye_0.png
    # dir/some_eye_0.xml
    # dir/some_eye_1.png
    # dir/some_eye_1.xml
    # ...

    configure_file("${eye_src_model_private}" "${eye_src_model}" COPYONLY)    
    configure_file("${eye_src_image_private}" "${eye_src_image}" COPYONLY)

    add_test(
      NAME
      "TrainRcprGenerate"
      COMMAND
      "drishti_train_cpr"
      "--dimensions={{0,1},{3},{0,1},{2}}"
      "--template=${eye_recipe_json}"
      )

    add_test(
      NAME
      "TrainRcpr"
      COMMAND
      "drishti_train_cpr"
      "--train=${eye_src_image}"
      "--test=${eye_src_image}"
      "--model=${eye_out_model}"
      "--recipe=${eye_recipe_json}"
      "--extension=.json"
      "--silent"      
      )

  endif()
  
endif()




